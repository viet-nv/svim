return {
	"mbbill/undotree",
	event = "BufReadPost", -- Load the plugin on buffer read
	config = function()
		-- Optional: set key mappings or additional configuration here
		vim.api.nvim_set_keymap("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>", { noremap = true, silent = true })
	end,
}
