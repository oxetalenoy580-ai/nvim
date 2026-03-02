return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- 启用 Nerd Fonts 图标
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{
				"<leader>md",
				"<cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
				desc = "Open DBUI in new tab",
			},
		},
	},
}
