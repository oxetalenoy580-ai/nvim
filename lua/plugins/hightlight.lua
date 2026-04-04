return {
	"tzachar/local-highlight.nvim",
	config = function()
		require("local-highlight").setup({
			insert_mode = false,
			hlgroup = "Search",
			min_match_len = 2,
			max_match_len = 50,
			animate = {
				enabled = false,
				-- easing = "linear",
			},
		})
		-- vim.keymap.set('n', '<leader>hl', '<cmd>LocalHighlightToggle<CR>')
	end,
}
