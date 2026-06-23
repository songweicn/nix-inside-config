return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.line_nr = "#7aa2f7"
      end,
      on_highlights = function(hl, colors)
        hl.LineNr = {
          fg = "#a9b1d6",
        }

        hl.CursorLineNr = {
          fg = "#c0caf5",
          bold = true,
        }
      end,
    },
  },
}
