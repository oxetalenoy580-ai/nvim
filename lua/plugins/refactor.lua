return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("refactoring").setup()
		-- 示例快捷键
		vim.keymap.set("x", "<leader>re", ":Refactor extract<CR>")
		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var<CR>")
	end,
}
