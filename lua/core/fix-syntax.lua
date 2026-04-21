vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 0

local filetype_map = {
	[".js"] = "javascript",
	[".ts"] = "typescript",
	[".py"] = "python",
	[".java"] = "java",
	[".html"] = "html",
	[".css"] = "css",
	[".lua"] = "lua",
	[".json"] = "json",
	[".md"] = "markdown",
	[".sh"] = "bash",
	[".s"] = "masm",
	[".ASM"] = "masm",
	[".asm"] = "masm",
	[".kdl"] = "kdl",
	[".jsx"] = "javascriptreact", -- React JSX文件
	[".tsx"] = "typescriptreact", -- React TSX文件
	[".vue"] = "vue", -- Vue单文件组件
	[".scss"] = "scss", -- SCSS样式
	[".sass"] = "sass", -- SASS样式
	[".less"] = "less", -- Less样式
	[".styl"] = "stylus", -- Stylus样式
	[".xml"] = "xml", -- XML/XML配置
	[".yaml"] = "yaml", -- YAML配置
	[".yml"] = "yaml", -- YAML简写
	[".toml"] = "toml", -- TOML配置
	[".svg"] = "svg", -- SVG矢量图
	[".json5"] = "json5", -- JSON5格式
	[".mjs"] = "javascript", -- ES模块JS
	[".cjs"] = "javascript", -- CommonJS模块JS

	[".c"] = "c", -- C语言
	[".h"] = "c", -- C头文件
	[".cpp"] = "cpp", -- C++
	[".hpp"] = "cpp", -- C++头文件
	[".go"] = "go", -- Go语言
	[".rs"] = "rust", -- Rust语言
	[".php"] = "php", -- PHP
	[".rb"] = "ruby", -- Ruby
	[".swift"] = "swift", -- Swift
	[".kt"] = "kotlin", -- Kotlin
	[".kts"] = "kotlin", -- Kotlin脚本
	[".scala"] = "scala", -- Scala
	[".pl"] = "perl", -- Perl
	[".pm"] = "perl", -- Perl模块
	[".hs"] = "haskell", -- Haskell
	[".dart"] = "dart", -- Dart/Flutter
	[".groovy"] = "groovy", -- Groovy
	[".zsh"] = "zsh", -- Zsh脚本
	[".fish"] = "fish", -- Fish脚本
	[".bat"] = "dosbatch", -- Windows批处理
	[".ps1"] = "powershell", -- PowerShell
	[".sql"] = "sql", -- SQL
	[".ini"] = "ini", -- INI配置
	[".conf"] = "config", -- 配置文件通用
	[".cfg"] = "config", -- 配置文件简写
	[".log"] = "log", -- 日志文件
	[".diff"] = "diff", -- 差异文件
	[".patch"] = "diff", -- 补丁文件

	[".vim"] = "vim", -- Vim脚本
	[".vimrc"] = "vim", -- Vim配置
	[".zshrc"] = "zsh", -- Zsh配置
	[".bashrc"] = "bash", -- Bash配置
	[".makefile"] = "make", -- Makefile（小写）
	["Makefile"] = "make", -- Makefile（大写）
	[".mk"] = "make", -- Makefile片段
	[".dockerfile"] = "dockerfile", -- Dockerfile（小写）
	["Dockerfile"] = "dockerfile", -- Dockerfile（大写）
	[".dockerignore"] = "dockerfile", -- Docker忽略文件
	[".gitignore"] = "gitignore", -- Git忽略文件
	[".gitconfig"] = "gitconfig", -- Git配置
	[".env"] = "sh", -- 环境变量文件（按Shell高亮）
	[".env.local"] = "sh", -- 本地环境变量
	[".lock"] = "json", -- 依赖锁文件（如package-lock.json）
	[".gradle"] = "groovy", -- Gradle构建文件
	[".gradle.kts"] = "kotlin", -- Gradle Kotlin脚本
	[".pom"] = "xml", -- Maven POM文件
	[".docker-compose.yml"] = "yaml", -- Docker Compose（特殊文件名）

	[".txt"] = "text", -- 纯文本
	[".rst"] = "rst", -- reStructuredText
	[".adoc"] = "asciidoc", -- AsciiDoc
	[".csv"] = "csv", -- CSV表格
	[".tsv"] = "tsv", -- TSV表格
	[".pdf"] = "pdf", -- PDF（仅语法识别，无内容高亮）
	[".docx"] = "text", -- Word文档（纯文本高亮）
	[".xlsx"] = "text", -- Excel表格（纯文本高亮）
	-- 可以根据需要添加更多映射
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	callback = function()
		local filename = vim.fn.expand("%:t")
		local ext = filename:match("^.+(%..+)$")

		if ext and filetype_map[ext] then
			vim.bo.filetype = filetype_map[ext]
			vim.opt_local.syntax = filetype_map[ext]
		else
			vim.opt_local.syntax = "text"
		end
	end,
})

vim.cmd("syntax enable")

local function fix_ts_queries()
	local ok, ts_query = pcall(require, "vim.treesitter.query")
	if not ok then
		return
	end

	local ts_dir = vim.fn.stdpath("data") .. "/site/queries"
	local lazy_ts_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime/queries"

	local langs =
		{ "ecma", "html", "javascript", "jsx", "lua", "python", "sql", "tsx", "typescript", "nasm", "c", "cpp", "java" }
	for _, lang in ipairs(langs) do
		local query_dir = vim.fn.isdirectory(lazy_ts_dir .. "/" .. lang) == 1 and lazy_ts_dir .. "/" .. lang
			or ts_dir .. "/" .. lang
		if vim.fn.isdirectory(query_dir) == 1 then
			local query_types = { "highlights", "locals", "folds", "indents", "injections" }
			for _, qt in ipairs(query_types) do
				local qf = query_dir .. "/" .. qt .. ".scm"
				if vim.fn.filereadable(qf) == 1 then
					local content = table.concat(vim.fn.readfile(qf), "\n")
					ts_query.set(lang, qt, content)
				end
			end
		end
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	once = true,
	callback = fix_ts_queries,
})
