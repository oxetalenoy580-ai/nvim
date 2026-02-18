return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
	},
	ft = "python", -- Load when opening Python files
	keys = {
		{ "<leader>cvs", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
		{ "<learder>cvl", "<cmd>VenvSelectLog<cr>" },
	},
	opts = {
		options = {
			log_level = "TRACE", -- enable VenvSelectLog command
		}, -- plugin-wide options
		search = {}, -- custom search definitions
	},
}
