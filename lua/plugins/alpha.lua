local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
}

function M.config()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	dashboard.section.header.val = {
		[[         _____     _____                        ]],
		[[  ___   ____(_)______  /_      __________   __  ]],
		[[  __ | / /_  /_  _ \  __/________  __ \_ | / /  ]],
		[[  __ |/ /_  / /  __/ /_ _/_____/  / / /_ |/ /   ]],
		[[  _____/ /_/  \___/\__/        /_/ /_/_____/    ]],
	}
	dashboard.section.buttons.val = {
		dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
		dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button(
			"p",
			" " .. " Find project",
			":lua require('telescope').extensions.projects.projects()<CR>"
		),
		dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	}
	local function footer()
		return "viet-nv"
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	dashboard.opts.opts.noautocmd = true
	alpha.setup(dashboard.opts)
end

return M
