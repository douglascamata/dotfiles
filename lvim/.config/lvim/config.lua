-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.exrc = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal Terminal" },
  v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical Terminal" },
  t = { "<cmd>ToggleTerm direction=float<cr>", "Float Terminal" },
}

table.insert(lvim.builtin.which_key.mappings["l"], { t = { "<cmd>SymbolsOutline<cr>", "Symbol outline" } })

lvim.builtin.terminal.size = function(term)
  if term.direction == "horizontal" then
    return 15
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end

lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "goimports", filetypes = { "go" } },
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  command = "normal zR",
})

-- lvim.plugins = {
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     event = "InsertEnter",
--     config = function()
--       require("copilot").setup({
--         suggestion = {
--           -- auto_trigger = true,
--           enabled = false,
--         },
--         panel = {
--           enabled = false,
--         },
--       })
--     end,
--   },
--   {
--     "zbirenbaum/copilot-cmp",
--     after = { "copilot.lua" },
--     config = function()
--       require("copilot_cmp").setup()
--     end,
--   },
-- }

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  suggestion = {
    enabled = false,
  },
  panel = {
    enabled = false,
  },
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

table.insert(lvim.plugins, {
  "simrat39/symbols-outline.nvim",
  config = function()
    require('symbols-outline').setup()
  end,
})
