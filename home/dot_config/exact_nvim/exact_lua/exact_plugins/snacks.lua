return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        formatters = {
          file = {
            filename_first = true,
          },
        },
        sources = {
          files = {
            hidden = true,
            layout = {
              preset = "default",
              preview = false,
            },
          },
          grep = {
            hidden = true,
          },
          explorer = {
            layout = {
              preset = "left",
            },
            hidden = true,
          },
        },
        -- util = {
        --   truncpath = function(path, len, opts)
        --     return Snacks.picker.util.truncpath(path, vim.o.columns, opts)
        --   end,
        -- },
      },
    },
  },
}
