local M = {
	"nvim-telescope/telescope.nvim",
	event = "Bufenter",
	cmd = { "Telescope" },
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			"ahmedkhalf/project.nvim",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			{
				"nvim-telescope/telescope-media-files.nvim", -- Add media files extension
				config = function()
					require("telescope").load_extension("media_files") -- Load the media files extension
				end,
			},
		},
	},
}

local actions = require("telescope.actions")

M.opts = {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
		mappings = {
			i = {
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "jpg", "jpeg", "webp", "pdf", "gif", "svg", "mp4" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
}

return M
