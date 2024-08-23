return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
	opts = {
		check_ts = true, -- Enable treesitter integration for better pair handling
		debug = true,
	},
}
