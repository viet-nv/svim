local function nvimtree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = nvimtree_on_attach,

			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
		})
		-- Open nvim-tree on startup
		vim.api.nvim_create_autocmd("VimEnter", {
			pattern = "*",
			callback = function()
				if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0) == "" then
					local current_win = vim.api.nvim_get_current_win()
					require("nvim-tree.api").tree.open()
					vim.api.nvim_set_current_win(current_win)
				end
			end,
		})
	end,
}
