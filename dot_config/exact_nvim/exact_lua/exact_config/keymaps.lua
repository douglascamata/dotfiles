-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  local vscode = require("vscode")
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymaps",
    callback = function()
      -- vim.keymap.set("n", "H", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>")
      -- vim.keymap.set("n", "L", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>")
      vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>call VSCodeNotify('editor.action.quickFix')<cr>")
      vim.keymap.set({ "n", "x" }, "<leader>cr", "<cmd>call VSCodeNotify('editor.action.rename')<cr>")
      vim.keymap.set("n", "<leader>cf", "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>")
      vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
      vim.keymap.set("n", "gy", "<cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<cr>")
      -- vim.keymap.set("n", "gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<cr>")
      vim.keymap.set("n", "gr", function()
        vscode.call("editor.action.goToReferences")
      end, {})
      vim.keymap.set("n", "gI", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<cr>")
      -- vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
      -- vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
    end,
  })
end
