let s:color_palette = Get_color_palette()

" ruby
call CHG("rubyInterpolationDelimiter",  {})
call CHG("rubyInstanceVariable",        {})
call CHG("rubyGlobalVariable",          {})
call CHG("rubyClassVariable",           {})
call CHG("rubyPseudoVariable",          {})
call CHG("rubyFunction",                { "fg": s:green })
call CHG("rubyStringDelimiter",         { "fg": s:yellow })
call CHG("rubyRegexp",                  { "fg": s:yellow })
call CHG("rubyRegexpDelimiter",         { "fg": s:yellow })
call CHG("rubySymbol",                  { "fg": s:purple })
call CHG("rubyEscape",                  { "fg": s:purple })
call CHG("rubyInclude",                 { "fg": s:pink })
call CHG("rubyOperator",                { "fg": s:pink })
call CHG("rubyControl",                 { "fg": s:pink })
call CHG("rubyClass",                   { "fg": s:pink })
call CHG("rubyDefine",                  { "fg": s:pink })
call CHG("rubyException",               { "fg": s:pink })
call CHG("rubyRailsARAssociationMethod",{ "fg": s:orange })
call CHG("rubyRailsARMethod",           { "fg": s:orange })
call CHG("rubyRailsRenderMethod",       { "fg": s:orange })
call CHG("rubyRailsMethod",             { "fg": s:orange })
call CHG("rubyConstant",                { "fg": s:aqua })
call CHG("rubyBlockArgument",           { "fg": s:orange })
call CHG("rubyBlockParameter",          { "fg": s:orange })