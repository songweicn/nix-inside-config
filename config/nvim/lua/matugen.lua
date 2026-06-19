 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fbf8ff',
    base01 = '#efedf3',
    base02 = '#eae7ed',
    base03 = '#767681',
    base04 = '#454650',
    base05 = '#1b1b20',
    base06 = '#1b1b20',
    base07 = '#1b1b20',
    base08 = '#ba1a1a',
    base09 = '#6f3568',
    base0A = '#595d79',
    base0B = '#3b4586',
    base0C = '#f9afea',
    base0D = '#bbc3ff',
    base0E = '#c2c4e5',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#1b1b20',          bg = '#fbf8ff' })
  hi('TelescopeBorder',         { fg = '#767681',             bg = '#fbf8ff' })
  hi('TelescopePromptNormal',   { fg = '#1b1b20',          bg = '#fbf8ff' })
  hi('TelescopePromptBorder',   { fg = '#767681',             bg = '#fbf8ff' })
  hi('TelescopePromptPrefix',   { fg = '#3b4586',             bg = '#fbf8ff' })
  hi('TelescopePromptCounter',  { fg = '#454650',  bg = '#fbf8ff' })
  hi('TelescopePromptTitle',    { fg = '#fbf8ff',             bg = '#3b4586' })
  hi('TelescopePreviewTitle',   { fg = '#fbf8ff',             bg = '#595d79' })
  hi('TelescopeResultsTitle',   { fg = '#fbf8ff',             bg = '#6f3568' })
  hi('TelescopeSelection',      { fg = '#1b1b20',          bg = '#eae7ed' })
  hi('TelescopeSelectionCaret', { fg = '#3b4586',             bg = '#eae7ed' })
  hi('TelescopeMatching',       { fg = '#3b4586',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
