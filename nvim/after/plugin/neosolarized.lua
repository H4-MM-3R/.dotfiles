 require('neosolarized').setup({
    comment_italics = true,
    background_set = true,
  })

  local cb = require('colorbuddy.init')

  local Color = cb.Color
  local colors = cb.colors
  local Group = cb.Group
  local groups = cb.groups
  local styles = cb.styles

  local cError = groups.Error.fg
  local cInfo = groups.Information.fg
  local cWarn = groups.Warning.fg
  local cHint = groups.Hint.fg

  Color.new('white', '#ffffff')
  Color.new('black', '#000000')

  Group.new('Visual', colors.none, colors.base03, styles.reverse)

  Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)

  Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
