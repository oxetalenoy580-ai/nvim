return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local dashboard = require("dashboard")
		-- 自定义 ASCII 艺术标题（可替换成你喜欢的样式）
		local header = {
			"",
			"",
			"",
			"",
			"",
			"",
			[[                                                                       ]],
			[[  ██████   █████                   █████   █████  ███                  ]],
			[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
			[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
			[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
			[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
			[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
			[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
			[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
			[[                                                                       ]],
			"                      Neovim - Code like a pro",
			"",
		}

		-- 自定义快捷按钮（图标+描述+命令）
		local buttons = {
			{
				icon = "  ", -- 搜索图标
				icon_hl = "DashboardIcon",
				desc = "Find File          ",
				desc_hl = "DashboardDesc",
				key = "f",
				key_hl = "DashboardKey",
				action = "Telescope find_files",
			},
			{
				icon = "  ", -- 历史图标
				icon_hl = "DashboardIcon",
				desc = "Recent Files       ",
				desc_hl = "DashboardDesc",
				key = "r",
				key_hl = "DashboardKey",
				action = "Telescope oldfiles",
			},
			{
				icon = "  ", -- 搜索文本图标
				icon_hl = "DashboardIcon",
				desc = "Find Text          ",
				desc_hl = "DashboardDesc",
				key = "g",
				key_hl = "DashboardKey",
				action = "Telescope live_grep",
			},
			{
				icon = "  ", -- 标记图标
				icon_hl = "DashboardIcon",
				desc = "Bookmarks          ",
				desc_hl = "DashboardDesc",
				key = "b",
				key_hl = "DashboardKey",
				action = "Telescope marks",
			},
			{
				icon = "  ", -- 设置图标
				icon_hl = "DashboardIcon",
				desc = "Config             ",
				desc_hl = "DashboardDesc",
				key = "c",
				key_hl = "DashboardKey",
				action = "edit $MYVIMRC",
			},
			{
				icon = "󰗼  ", -- 退出图标
				icon_hl = "DashboardIcon",
				desc = "Quit               ",
				desc_hl = "DashboardDesc",
				key = "q",
				key_hl = "DashboardKey",
				action = "qa",
			},
		}

		-- 配置 dashboard 核心参数
		dashboard.setup({
			theme = "doom", -- 基础主题（doom 是最简洁美观的）
			hide = {
				statusline = true, -- 隐藏状态栏
				tabline = true, -- 隐藏标签栏
				winbar = true, -- 隐藏 winbar
			},
			config = {
				header = header, -- 自定义标题
				center = buttons, -- 自定义快捷按钮
				footer = function()
					-- 底部显示 Neovim 版本 + 加载时间
					local version = vim.version()
					local nvim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
					local load_time =
						string.format("%.2fms", vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000)
					return {
						"",
						"�_VERSION: " .. nvim_version .. " | LOAD TIME: " .. load_time,
						"󰚰  Happy Coding ~",
						"",
					}
				end,
			},
		})

		-- 自定义高亮组（适配深色主题，可根据你的主题调整）
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa", bold = true }) -- 标题颜色
		vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#cba6f7" }) -- 图标颜色
		vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#a6e3a1" }) -- 描述颜色
		vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f9e2af", bold = true }) -- 快捷键颜色
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#94e2d5" }) -- 底部信息颜色
	end,
}
