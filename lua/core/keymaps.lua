-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "learder" })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set(
	{ "n", "v" },
	"k",
	"v:count == 0 ? 'gk' : 'k'",
	{ expr = true, silent = true, desc = "Move up (wrap-aware)" }
)
vim.keymap.set(
	{ "n", "v" },
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ expr = true, silent = true, desc = "Move down (wrap-aware)" }
)

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlights" }))

-- save file
-- vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", vim.tbl_extend("force", opts, { desc = "Save current file" }))

-- quit file
-- vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", vim.tbl_extend("force", opts, { desc = "Quit current buffer" }))

-- delete without copying into register
vim.keymap.set({ "n", "v" }, "x", '"_x', vim.tbl_extend("force", opts, { desc = "Delete char (no register copy)" }))
vim.keymap.set("n", "xx", [["_dd]], vim.tbl_extend("force", opts, { desc = "Delete line (no register copy)" }))

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", vim.tbl_extend("force", opts, { desc = "Scroll down and center cursor" }))
vim.keymap.set("n", "<C-u>", "<C-u>zz", vim.tbl_extend("force", opts, { desc = "Scroll up and center cursor" }))

-- Find and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))
-- vim.keymap.set("n", "<C-i>", "<C-i>", vim.tbl_extend("force", opts, { desc = "Jump forward (restore default)" }))
vim.keymap.set("n", "<leader>bx", ":Bdelete!<CR>", vim.tbl_extend("force", opts, { desc = "Close current buffer" }))

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
vim.keymap.set("n", "<leader>h", "<C-w>s", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
-- vim.keymap.set("n", "<leader>se", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize split window sizes" }))
-- vim.keymap.set("n", "<leader>sx", ":close<CR>", vim.tbl_extend("force", opts, { desc = "Close current split window" }))

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", vim.tbl_extend("force", opts, { desc = "Move to upper split window" }))
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", vim.tbl_extend("force", opts, { desc = "Move to lower split window" }))
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", vim.tbl_extend("force", opts, { desc = "Move to left split window" }))
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", vim.tbl_extend("force", opts, { desc = "Move to right split window" }))

-- Tabs
-- vim.keymap.set("n", "<leader>to", ":tabnew<CR>", vim.tbl_extend("force", opts, { desc = "Open new tab" }))
-- vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", vim.tbl_extend("force", opts, { desc = "Close current tab" }))
-- vim.keymap.set("n", "<leader>tn", ":tabn<CR>", vim.tbl_extend("force", opts, { desc = "Go to next tab" }))
-- vim.keymap.set("n", "<leader>tp", ":tabp<CR>", vim.tbl_extend("force", opts, { desc = "Go to previous tab" }))

-- Toggle line wrapping
vim.keymap.set(
	"n",
	"<leader>lw",
	"<cmd>set wrap!<CR>",
	vim.tbl_extend("force", opts, { desc = "Toggle line wrapping" })
)

-- Press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode (jk)" }))
vim.keymap.set("i", "kj", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode (kj)" }))

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", vim.tbl_extend("force", opts, { desc = "Indent left (keep selection)" }))
vim.keymap.set("v", ">", ">gv", vim.tbl_extend("force", opts, { desc = "Indent right (keep selection)" }))

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m >+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selected text down" }))
vim.keymap.set("v", "<A-k>", ":m <-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selected text up" }))

-- move line up and down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "Move line up" }))
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "Move line down" }))

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', vim.tbl_extend("force", opts, { desc = "Paste without overwriting register" }))

-- Yank（复制）时高亮提示
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

-- Replace word under cursor
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>j",
-- 	"*``cgn",
-- 	vim.tbl_extend("force", opts, { desc = "Replace word under cursor (multi)" })
-- )

-- Explicitly yank to system clipboard (highlighted and entire row)
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], vim.tbl_extend("force", opts, { desc = "Yank to system clipboard" }))
-- vim.keymap.set("n", "<leader>Y", [["+Y]], vim.tbl_extend("force", opts, { desc = "Yank line to system clipboard" }))

-- Toggle diagnostics
-- local diagnostics_active = true

-- vim.keymap.set("n", "<leader>dx", function()
-- 	diagnostics_active = not diagnostics_active
--
-- 	if diagnostics_active then
-- 		vim.diagnostic.enable(true)
-- 	else
-- 		vim.diagnostic.enable(false)
-- 	end
-- end, vim.tbl_extend("force", opts, { desc = "Toggle diagnostics display" }))

-- vim.keymap.set(
-- 	"n",
-- 	"<leader>do",
-- 	vim.diagnostic.open_float,
-- 	vim.tbl_extend("force", opts, { desc = "Open floating diagnostic" })
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dl",
-- 	vim.diagnostic.setloclist,
-- 	vim.tbl_extend("force", opts, { desc = "Open diagnostics list" })
-- )

-- Save and load session
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>ss",
-- 	":mksession! .session.vim<CR>",
-- 	{ noremap = true, silent = false, desc = "Save current session" }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>sl",
-- 	":source .session.vim<CR>",
-- 	{ noremap = true, silent = false, desc = "Load saved session" }
-- )

--toggleterm
-- vim.keymap.set(
-- 	{ "n" },
-- 	"<leader>Rp",
-- 	'<Cmd>TermExec  cmd="python %"<CR>',
-- 	vim.tbl_extend("force", opts, { desc = "Run current Python file" })
-- )
-- vim.keymap.set(
-- 	{ "n" },
-- 	"<leader>Rj",
-- 	'<Cmd>TermExec  cmd="node %"<CR>',
-- 	vim.tbl_extend("force", opts, { desc = "Run current Javascript file" })
-- )
-- vim.keymap.set(
-- 	{ "n" },
-- 	"<leader>RJ",
-- 	'<Cmd>TermExec  cmd="java %"<CR>',
-- 	vim.tbl_extend("force", opts, { desc = "Run current Java file" })
-- )
