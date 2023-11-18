local cb = require('colorbuddy.init')

local colors = cb.colors
local Group = cb.Group
local groups = cb.groups
local styles = cb.styles

 require('neosolarized').setup({
    comment_italics = true,
    background_set = true,
  })

  Group.new('CursorLineNR', colors.base2, colors.base02, styles.NONE)
  Group.new('TSVariable', colors.base1, colors.none)
  Group.new('Visual', colors.none, colors.base03, styles.reverse)


  local cError = groups.Error.fg
  local cInfo = groups.Information.fg
  local cWarn = groups.Warning.fg
  local cHint = groups.Hint.fg


  Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
  Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
  Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
  Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

  Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)

   Group.new("TodoBgFIX", colors.base03, colors.red, styles.bold)
   Group.new("TodoFgFIX", colors.red)
   Group.new("TodoSignFIX", colors.red)
   Group.new("TodoBgTODO", colors.base03, colors.blue, styles.bold)
   Group.new("TodoFgTODO", colors.blue)
   Group.new("TodoSignTODO", colors.blue)
   Group.new("TodoBgWARN", colors.base03, colors.yellow, styles.bold)
   Group.new("TodoFgWARN", colors.yellow)
   Group.new("TodoSignWARN", colors.yellow)
   Group.new("TodoBgPERF", colors.base03, colors.violet, styles.bold)
   Group.new("TodoFgPERF", colors.violet)
   Group.new("TodoSignPERF", colors.violet)
   Group.new("TodoBgNOTE", colors.base03, colors.cyan, styles.bold)
   Group.new("TodoFgNOTE", colors.cyan)
   Group.new("TodoSignNOTE", colors.cyan)
   Group.new("TodoBgTEST", colors.base03, colors.green, styles.bold)
   Group.new("TodoFgTEST", colors.green)
   Group.new("TodoSignTEST", colors.green)
