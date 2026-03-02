-- 1. 禁用 Neovim 内置的文件类型检测
vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 0

-- 2. 手动定义文件类型映射
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
	-- 可以根据需要添加更多映射
}

-- 3. 创建自动命令，在打开文件时强制设置文件类型和语法
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	callback = function()
		local filename = vim.fn.expand("%:t")
		local ext = filename:match("^.+(%..+)$")

		if ext and filetype_map[ext] then
			vim.bo.filetype = filetype_map[ext]
			vim.opt_local.syntax = filetype_map[ext]
		end
	end,
})

-- 4. 确保语法高亮全局启用
vim.cmd("syntax enable")

-- 修复 Tree-sitter 查询文件加载问题
local function fix_ts_queries()
	-- 检查 tree-sitter 是否加载
	local ok, ts_query = pcall(require, "vim.treesitter.query")
	if not ok then
		return
	end

	-- 解析器安装目录（对应健康检查里的路径）
	local ts_dir = vim.fn.stdpath("data") .. "/site/queries"
	-- 兼容 LazyVim 的插件目录
	local lazy_ts_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime/queries"

	-- 遍历所有已安装的语言（从健康检查里提取）
	local langs = { "ecma", "html", "javascript", "jsx", "lua", "python", "sql", "tsx", "typescript" }
	for _, lang in ipairs(langs) do
		-- 优先用 LazyVim 的查询文件，其次用解析器目录的
		local query_dir = vim.fn.isdirectory(lazy_ts_dir .. "/" .. lang) == 1 and lazy_ts_dir .. "/" .. lang
			or ts_dir .. "/" .. lang
		if vim.fn.isdirectory(query_dir) == 1 then
			-- 加载所有核心查询文件（H/L/F/I/J 对应）
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

-- 插件加载完成后执行
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	once = true,
	callback = fix_ts_queries,
})
