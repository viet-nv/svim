-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	-- Pin to the legacy `master` API: this config uses `require('nvim-treesitter.configs').setup()`
	-- with ensure_installed/highlight/indent, which the new `main`-branch rewrite removed.
	branch = "master",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"rust",
			"javascript",
			"typescript",
			"tsx",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		autopairs = {
			enable = true,
		},

		-- autotag = {
		-- 	enable = true,
		-- },

		indent = { enable = true },
	},
	config = function(_, opts)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)

		-- Neovim 0.12 compat for nvim-treesitter's frozen `master` branch.
		--
		-- 0.12 removed the legacy `all = false` single-node mode: query
		-- predicate/directive handlers now always receive `match` as
		-- `table<integer, TSNode[]>` (a list of nodes per capture). The master
		-- branch still assumes a single TSNode, so its markdown/html injection
		-- directives call get_node_text() on a list -> `node:range()` is nil and
		-- crashes (e.g. running :MarkdownPreview / render-markdown parsing a code
		-- fence). Re-register the affected handlers with list-aware lookup.
		local tsq = require("vim.treesitter.query")

		-- Return the (last) captured TSNode for a capture id, tolerating both the
		-- new list shape and a bare node, mirroring the old single-node semantics.
		local function node_of(match, id)
			local n = match[id]
			if type(n) == "table" then
				n = n[#n]
			end
			return n
		end

		local non_filetype_match_injection_language_aliases = {
			ex = "elixir",
			pl = "perl",
			sh = "bash",
			uxn = "uxntal",
			ts = "typescript",
		}

		local html_script_type_languages = {
			["importmap"] = "json",
			["module"] = "javascript",
			["application/ecmascript"] = "javascript",
			["text/ecmascript"] = "javascript",
		}

		local function parser_from_info_string(alias)
			local m = vim.filetype.match({ filename = "a." .. alias })
			return m or non_filetype_match_injection_language_aliases[alias] or alias
		end

		tsq.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
			local node = node_of(match, pred[2])
			if not node then
				return
			end
			local alias = vim.treesitter.get_node_text(node, bufnr):lower()
			metadata["injection.language"] = parser_from_info_string(alias)
		end, { force = true })

		tsq.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
			local node = node_of(match, pred[2])
			if not node then
				return
			end
			local value = vim.treesitter.get_node_text(node, bufnr)
			local configured = html_script_type_languages[value]
			if configured then
				metadata["injection.language"] = configured
			else
				local parts = vim.split(value, "/", {})
				metadata["injection.language"] = parts[#parts]
			end
		end, { force = true })

		tsq.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
			local id = pred[2]
			local node = node_of(match, id)
			if not node then
				return
			end
			local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
			if not metadata[id] then
				metadata[id] = {}
			end
			metadata[id].text = string.lower(text)
		end, { force = true })

		tsq.add_predicate("nth?", function(match, _, _, pred)
			local node = node_of(match, pred[2])
			local n = tonumber(pred[3])
			if node and node:parent() and node:parent():named_child_count() > n then
				return node:parent():named_child(n) == node
			end
			return false
		end, { force = true })

		tsq.add_predicate("kind-eq?", function(match, _, _, pred)
			local node = node_of(match, pred[2])
			if not node then
				return true
			end
			return vim.tbl_contains({ unpack(pred, 3) }, node:type())
		end, { force = true })

		tsq.add_predicate("is?", function(match, _, bufnr, pred)
			local node = node_of(match, pred[2])
			if not node then
				return true
			end
			local locals = require("nvim-treesitter.locals")
			local _, _, kind = locals.find_definition(node, bufnr)
			return vim.tbl_contains({ unpack(pred, 3) }, kind)
		end, { force = true })

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
