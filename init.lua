require("core.options")
require("core.neovide")
require("core.fix-syntax")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.neotree"),
	require("plugins.lualine"),
	require("plugins.bufferLine"),
	require("plugins.telescope"),
	require("plugins.which-key"),
	require("plugins.treesitter"),
	require("plugins.mini"),
	require("plugins.harpoon"),
	require("plugins.wilder"),
	require("plugins.mason"),
	require("plugins.lspconfig"),
	require("plugins.formatting"),
	require("plugins.nvim-cmp"),
	require("plugins.noise"),
	require("plugins.linting"),
	require("plugins.gitsigns"),
	require("plugins.lazygit"),
	require("plugins.auto-pair"),
	require("plugins.emment"),
	require("plugins.toggleterm"),
	require("plugins.rainbow-delimiters"),
	require("plugins.indent"),
	require("plugins.venv-selector"),
	require("plugins.refactor"),
	require("plugins.opencode"),
	require("plugins.dap"),
	require("plugins.multicursor"),
	require("plugins.nvim-jdtls"),
	require("plugins.hightlight"),
    require("plugins.snack")
	-- require("plugins.flash"),
	-- require("plugins.oil"),
	-- require("plugins.trouble"),
	-- require("plugins.showkeys"),
	-- require("plugins.smear-cursor"),
	-- require("plugins.vim-dadbod-ui"),
	-- require("plugins.syntax"),
})
