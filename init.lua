require("core.fix-syntax")
require("core.keymaps")
require("core.options")

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
	-- require("plugins.oil"),
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
	require("plugins.trouble"),
	require("plugins.gitsigns"),
	require("plugins.lazygit"),
	-- require("plugins.showkeys"),
	require("plugins.auto-pair"),
	require("plugins.emment"),
	require("plugins.smear-cursor"),
	require("plugins.dashboard"),
	require("plugins.toggleterm"),
	require("plugins.rainbow-delimiters"),
	require("plugins.indent-blankline"),
	require("plugins.flash"),
	require("plugins.venv-selector"),
	require("plugins.refactor"),
	-- require("plugins.vim-dadbod-ui"),
	-- require("plugins.syntax"),
})

-- 在 init.lua 中添加这段代码
-- local function load_python_queries()
-- 	local ts_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
-- 	local query_dir = ts_runtime .. "/queries/python"
--
-- 	-- 强制加载高亮规则
-- 	for _, query_type in ipairs({ "highlights", "indents", "locals", "injections", "folds" }) do
-- 		local query_file = query_dir .. "/" .. query_type .. ".scm"
-- 		if vim.fn.filereadable(query_file) == 1 then
-- 			local query = table.concat(vim.fn.readfile(query_file), "\n")
-- 			require("vim.treesitter.query").set("python", query_type, query)
-- 		end
-- 	end
-- end
--
-- -- 当打开 Python 文件时执行
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "python",
-- 	callback = load_python_queries,
-- })
--
-- -- 在 init.lua 中添加这段代码
-- local function load_js_queries()
-- 	local ts_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
-- 	local query_dir = ts_runtime .. "/queries/javascript"
--
-- 	-- 强制加载高亮规则
-- 	for _, query_type in ipairs({ "highlights", "indents", "locals", "injections", "folds" }) do
-- 		local query_file = query_dir .. "/" .. query_type .. ".scm"
-- 		if vim.fn.filereadable(query_file) == 1 then
-- 			local query = table.concat(vim.fn.readfile(query_file), "\n")
-- 			require("vim.treesitter.query").set("javascript", query_type, query)
-- 		end
-- 	end
-- end
--
-- -- 当打开 Python 文件时执行
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "javascript",
-- 	callback = load_js_queries,
-- })
