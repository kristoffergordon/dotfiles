vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect", "popup" }

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
local map = vim.keymap.set
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Grep in project" })
map("n", "<leader>fb", fzf.buffers, { desc = "Open buffers" })
map("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Diagnostics" })
map("n", "<leader>fr", fzf.resume, { desc = "Resume last search" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
    },
  },
})

vim.lsp.enable({ "basedpyright", "ruff", "bashls", "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if #vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/formatting" }) > 0 then
      vim.lsp.buf.format({ bufnr = args.buf })
    end
  end,
})
