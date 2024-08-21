local function map(mode, lhs, rhs, desc)
	-- Default options
	local options = { silent = true }

	-- If additional options are provided, merge them with the default options
	if desc then
		options = vim.tbl_extend("force", options, { desc = desc })
	end

	vim.keymap.set(mode, lhs, rhs, options)
end
--Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.localleader = " "

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("n", "<C-l>", "<C-w><C-l>", "Move focus to the right window")
map("n", "<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("n", "<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- Save file
map("n", "<C-s>", ":w<CR>")
-- Resize with arrows
map("n", "<C-S-Up>", ":resize -2<CR>")
map("n", "<C-S-Down>", ":resize +2<CR>")
map("n", "<C-S-Left>", ":vertical resize -2<CR>")
map("n", "<C-S-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Clear highlights
map("n", "<leader>h", "<cmd>nohlsearch<CR>")

-- Better paste
map("v", "p", '"_dP')

-- Insert --
-- Press jk fast to enter
map("i", "jk", "<ESC>")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Plugins --
--
-- NvimTree
map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<leader>nf", ":NvimTreeFocus<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", "[F]ind [F]iles")
map("n", "<leader>fg", ":Telescope live_grep<CR>", "[F]ind by [G]rep")
map("n", "<leader>fr", ":Telescope resume<CR>", "[F]ind by [R]esume")
map("n", "<leader>fp", ":Telescope projects<CR>", "[F]ind [P]rojects")
map("n", "<leader>fb", ":Telescope buffers<CR>", "[F]ind [B]uffers")
map("n", "<leader>fm", ":Telescope media_files<CR>", "[F]ind [M]edia files")
--  To jump back, press <C-t>.
map("n", "gd", ":Telescope lsp_definations<CR>", "[G]oto [D]efinition")
map("n", "gr", ":Telescope lsp_implementations<CR>", "[G]oto [I]mplementation")
map("n", "gI", ":Telescope lsp_implementations<CR>", "[G]oto [I]mplementation")
map("n", "<leader>D", ":Telescope lsp_type_definitions", "Type [D]efinition")
map("n", "<leader>ds", ":Telescope lsp_document_symbols", "[D]ocument [S]ymbols")
map("n", "<leader>ws", ":Telescope lsp_dynamic_workspace_symbols", "[W]orkspace [S]ymbols")
map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
-- Execute a code action, usually your cursor needs to be on top of an error
-- or a suggestion from your LSP for this to activate.
map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
-- WARN: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
