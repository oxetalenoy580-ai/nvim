return {
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokai_transparent_background = "1"
			vim.g.sonokai_enable_italic = "1"
			vim.g.sonokai_style = "andromeda"
			-- vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				float = {
					transparent = false, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					telescope = true,
				},
				styles = {},

				custom_highlights = function(colors)
					return {
						LineNr = { fg = colors.overlay0 },
						CursorLineNr = { fg = colors.peach, style = { "bold" } },
						LineNrAbove = { fg = colors.overlay1 },
						LineNrBelow = { fg = colors.overlay1 },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
