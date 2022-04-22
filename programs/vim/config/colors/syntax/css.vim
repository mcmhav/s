let s:color_palette = Get_color_palette()

" CSS
call CHG("cssProp",             { "fg": s:color_palette.red })
call CHG("cssUIAttr",           { "fg": s:color_palette.yellow })
call CHG("cssFunctionName",     { "fg": s:color_palette.aqua })
call CHG("cssColor",            { "fg": s:color_palette.purple })
call CHG("cssPseudoClassId",    { "fg": s:color_palette.purple })
call CHG("cssClassName",        { "fg": s:color_palette.green })
call CHG("cssValueLength",      { "fg": s:color_palette.purple })
call CHG("cssCommonAttr",       { "fg": s:color_palette.pink })
call CHG("cssBraces" ,          { "fg": s:color_palette.white })
call CHG("cssClassNameDot",     { "fg": s:color_palette.pink })
call CHG("cssURL",              { "fg": s:color_palette.orange, "format": "underline,italic" })
