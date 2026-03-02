-- ~/.config/nvim/lua/plugins/syntax.lua
return {
	-- 增强 Vim 原生语法高亮（支持 Python/JS/Java 等所有语言）
	"sheerun/vim-polyglot",
	-- 优化高亮性能（大文件也不卡）
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		-- 全局启用原生语法高亮
		vim.cmd("filetype plugin indent on")
		vim.opt.syntax = "enable"
		vim.opt.filetype = "on"

		-- 针对 Python 优化高亮（解决 3.14 新语法支持问题）
		vim.g.python_highlight_all = 1
		vim.g.python_version_3 = 1

		-- 针对 JS/TS 优化高亮
		vim.g.javascript_plugin_jsdoc = 1
		vim.g.typescript_plugin_flow = 1

		-- 禁用冗余的语法检测，提升速度
		vim.g.polyglot_disabled = { "autoindent", "folding" }
	end,
}
