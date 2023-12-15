evaluate-commands %sh{
    black="rgb:393B44"
    red="rgb:C94F6D"
    red_dim="rgb:2F2837"
    green="rgb:81B29A"
    green_dim="rgb:26343C"
    yellow="rgb:DBC074"
    yellow_bright="rgb:E0C989"
    blue="rgb:719CD6"
    blue_bright="rgb:86ABDC"
    blue_dim="rgb:2F2837"
    magenta="rgb:9D79D6"
    magenta_bright="rgb:BAA1E2"
    cyan="rgb:63CDCF"
    cyan_bright="rgb:7AD4D6"
    cyan_dim="rgb:253F4A"
    white="rgb:DFDFE0"
    orange="rgb:F4A261"
    orange_bright="rgb:F6B079"
    pink="rgb:D67AD2"
    pink_bright="rgb:DC8ED9"
    comment="rgb:738091"
    bg0="rgb:131A24"
    bg1="rgb:192330"
    bg2="rgb:212E3F"
    bg3="rgb:29394F"
    bg4="rgb:39506D"
    fg0="rgb:D6D6D7"
    fg1="rgb:CDCECF"
    fg2="rgb:AEAFB0"
    fg3="rgb:71839B"
    sel0="rgb:2B3B51"
    sel1="rgb:3C5372"

    echo "
        face global Default ${fg1},${bg1}
        face global BufferPadding @Default
        face global PrimarySelection ${fg1},${sel1}
        face global SecondarySelection ${fg1},${bg4}

        face global PrimaryCursor ${fg1},${bg1}
        face global SecondaryCursor ${fg3},${bg1}
        face global MatchingChar ${yellow}+b@PrimaryCursor

        face global LineNumbers ${fg3},${bg1}
        face global LineNumberCursor ${yellow},${bg1}+b

        face global MenuForeground ${fg1},${fg3}
        face global MenuBackground ${fg1},${sel0}
        face global MenuInfo ${fg1},${sel0}

        face global StatusLine ${fg2},${bg0}
        face global StatusLineMode ${green},${bg0}
        face global StatusLineInfo ${blue},${bg0}
        face global StatusLineValue ${fg2},${bg0}

        face global Prompt ${fg2},${bg0}
        face global Whitespace ${bg3}
        face global InlayHint ${comment},${bg2}
        face global Information ${blue}+c
        face global Error ${red}+c

        face global title ${yellow}+b
        face global header ${yellow}+b
        face global bold ${orange}+b
        face global italic ${pink}
        face global list ${magenta}+b
        face global link ${yellow_bright}+b
        face global block ${magenta}
        face global mono ${orange}

        face global InlayDiagnosticHint ${green}
        face global InlayDiagnosticError ${red}+u
        face global InlayDiagnosticInfo ${blue}+u
        face global InlayDiagnosticWarning ${yellow}+u

        face global InfoDefault ${fg1},${bg0}
        face global InfoBlock ${magenta}@InfoDefault
        face global InfoBlockQuote ${blue}@InfoDefault
        face global InfoBullet ${magenta}+b@InfoDefault
        face global InfoHeader ${yellow}+b@InfoDefault
        face global InfoLink ${yellow_bright}+b@InfoDefault
        face global InfoLinkMono @InfoLink
        face global InfoMono ${orange}@InfoDefault
        face global InfoDiagnosticHint ${green}@InfoDefault
        face global InfoDiagnosticWarning ${yellow}@InfoDefault
        face global InfoDiagnosticInfo ${blue}@InfoDefault

        face global variable ${white}
        face global variable_builtin ${red}
        face global variable_parameter ${cyan_bright}
        face global variable_other_member ${fg2}

        face global type ${yellow}
        face global type_builtin ${cyan_bright}
        face global type_enum_variant ${orange_bright}

        face global module ${cyan_bright}

        face global special ${fg2} 
        face global attribute ${yellow }

        face global constructor ${magenta}

        face global constant ${orange_bright}
        face global constant_builtin ${orange_bright}
        face global constant_builtin_boolean ${orange}
        face global constant_character ${green}
        face global constant_character_escape ${yellow_bright}+b
        face global constant_numeric ${orange}
        face global string ${green}
        face global string_regexp ${yellow_bright }
        face global string_special ${yellow_bright}+b
        face global string_special_url ${cyan}+b
        face global comment ${ comment }
        face global comment_block_documentation ${comment}+b
        face global label ${magenta_bright}
        face global punctuation {fg2}
        face global keyword ${magenta}
        face global keyword_control ${pink}
        face global keyword_control_conditional ${magenta_bright}
        face global keyword_control_repeat ${magenta_bright}
        face global keyword_control_import ${pink_bright}
        face global keyword_control_return ${magenta}
        face global keyword_control_exception ${magenta}
        face global keyword_operator ${fg2}+b
        face global keyword_directive ${pink_bright}
        face global keyword_function ${red}
        face global keyword_storage ${magenta}
        face global keyword_storage_type ${magenta}
        face global keyword_storage_modifier {yellow}
        face global identifier @keyword_storage_modifier
        face global operator ${fg2}
        face global function ${blue_bright}
        face global function_builtin ${red}
        face global function_macro ${red}
        face global meta @function_macro
        face global tag ${blue_bright}
    "
}
