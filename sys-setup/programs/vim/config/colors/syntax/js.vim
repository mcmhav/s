let s:color_palette = Get_color_palette()

" Javascript
call CHG("jsClassKeyword",      { "fg": s:aqua, "format": "italic" })
call CHG("jsGlobalObjects",     { "fg": s:aqua, "format": "italic" })
call CHG("jsFuncName",          { "fg": s:green })
call CHG("jsThis",              { "fg": s:orange, "format": "italic" })
call CHG("jsFunctionKey",       { "fg": s:green })
call CHG("jsPrototype",         { "fg": s:aqua })
call CHG("jsExceptions",        { "fg": s:aqua })
call CHG("jsFutureKeys",        { "fg": s:aqua })
call CHG("jsBuiltins",          { "fg": s:aqua })
call CHG("jsArgsObj",           { "fg": s:aqua })
call CHG("jsStatic",            { "fg": s:aqua })
call CHG("jsSuper",             { "fg": s:orange, "format": "italic" })
call CHG("jsFuncArgRest",       { "fg": s:purple, "format": "italic" })
call CHG("jsFuncArgs",          { "fg": s:orange, "format": "italic" })
call CHG("jsStorageClass",      { "fg": s:aqua, "format": "italic" })
call CHG("jsDocTags",           { "fg": s:aqua,   "format": "italic" })
call CHG("jsFunction",         { "fg": s:aqua,   "format": "italic" })

"call CHG("jsDestructuringProperty", { "fg": s:orange })
"call CHG("jsDestructuringAssignment", { "fg": s:orange })
"call CHG("jsDestructuringValue", { "fg": s:orange })
"call CHG("jsDestructuringValueAssignment", { "fg": s:orange })
"call CHG("jsDestructuringPropertyValue", { "fg": s:orange })
"call CHG("jsDestructuringPropertyComputed", { "fg": s:orange })
call CHG("jsDestructuringBlock", { "fg": s:orange })
" call CHG("jsRestExpression", { "fg": s:orange })
call CHG("jsSpreadExpression", { "fg": s:orange })

call CHG("jsObjectKey", { "fg": s:aqua })
call CHG("jsObjectShorthandProp", { "fg": s:aqua })

" separators
call CHG("jsNoise", { "fg": s:separator_color })
call CHG("jsDot", { "fg": s:separator_color })
call CHG("jsObjectColon", { "fg": s:separator_color })
call CHG("jsObjectSeparator", { "fg": s:separator_color })
call CHG("jsDestructuringNoise", { "fg": s:separator_color })

call CHG("jsReturn",          { "fg": s:keywords_color,   "format": "italic" })
call CHG("jsxComponentName", {"fg": s:function_color })