return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values

		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		-- NOTE: Experimenting
		-- Telescope into Harpoon function
		-- comment this function if you don't like it
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>Ha", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<leader>He", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open Harpoon Windows" })

		--Harpoon marked files
		vim.keymap.set("n", "<A-1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<A-2>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<A-3>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<A-4>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>Hp", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon Buffer" })
		vim.keymap.set("n", "<leader>Hn", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon Buffer" })

		-- Telescope inside Harpoon Window
		vim.keymap.set("n", "<leader>Hs", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open list in Telescope" })
	end,
}
