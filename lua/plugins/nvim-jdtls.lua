return {
	-- 1. Java 官方标准 LSP 插件（必须用这个！）
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local jdtls = require("jdtls")
			local home = os.getenv("HOME")

			local config = {
				cmd = {
					"jdtls",
					"--jvm-arg=-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
				},
				root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
				settings = {
					java = {
						autobuild = { enabled = true },
						home = os.getenv("JAVA_HOME"),
					},
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					jdtls.start_or_attach(config)
				end,
			})
		end,
	},
}
