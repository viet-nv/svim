local M = {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
}

function M.config()
	require("colorizer").setup()
end

return M
