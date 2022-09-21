require('ayu').setup({
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
        -- Set the cursor line to a better color
        CursorLine = { bg = '#131721' }
    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

require('ayu').colorscheme()

