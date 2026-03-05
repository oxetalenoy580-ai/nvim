return {
	"sheerun/vim-polyglot",
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		vim.cmd("filetype plugin indent on")
		vim.opt.syntax = "enable"
		vim.opt.filetype = "on"

		vim.g.python_highlight_all = 1
		vim.g.python_version_3 = 1

		vim.g.javascript_plugin_jsdoc = 1
		vim.g.typescript_plugin_flow = 1

		vim.g.polyglot_disabled = { "autoindent", "folding" }
	end,
}
