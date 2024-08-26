return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		-- signs = {
		-- 	add = { text = "+" },
		-- 	change = { text = "~" },
		-- 	delete = { text = "_" },
		-- 	topdelete = { text = "‾" },
		-- 	changedelete = { text = "~" },
		-- },
		current_line_blame = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		attach_to_untracked = true,
	},
}
