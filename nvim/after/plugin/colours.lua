vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  term_colors = true,
  compile = {
    enabled = true, 
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  integrations = {
    telescope = true,
    barbar = true,
    cmp = true,
    nvimtree = true,
    treesitter = true,
  }
})
-- vim.g.colorscheme = "gruvbox"


vim.api.nvim_create_autocmd("OptionSet", {
 	pattern = "background",
 	callback = function()
 		vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "mocha"))
 	end,
})

-- function LightScheme()
--     vim.g.gruvbox_contrast_light = 'soft'
--     vim.g.gruvbox_invert_selection = '0'
--     vim.opt.background = "light"
-- 
--     vim.cmd("colorscheme " .. vim.g.colorscheme)
-- 
--     local hl = function(thing, opts)
--         vim.api.nvim_set_hl(0, thing, opts)
--     end
-- 
--     hl("SignColumn", {
--         bg = "none",
--     })
-- 
--     hl("ColorColumn", {
--         ctermbg = 0,
--         bg = "#555555",
--     })
-- 
--     hl("CursorLineNR", {
--         bg = "None"
--     })
-- 
--     --hl("Normal", {
--     --    bg = "white"
--     --})
-- 
--     hl("LineNr", {
--         fg = "#5eacd3"
--     })
-- 
--     hl("netrwDir", {
--         fg = "#5eacd3"
--     })
-- 
-- end
-- 
-- function DarkScheme()
--     vim.g.gruvbox_contrast_dark = 'hard'
--     vim.g.gruvbox_invert_selection = '0'
--     vim.opt.background = "dark"
-- 
--     vim.cmd("colorscheme " .. vim.g.colorscheme)
-- 
--     local hl = function(thing, opts)
--         vim.api.nvim_set_hl(0, thing, opts)
--     end
-- 
--     hl("SignColumn", {
--         bg = "none",
--     })
-- 
--     hl("ColorColumn", {
--         ctermbg = 0,
--         bg = "#555555",
--     })
-- 
--     hl("CursorLineNR", {
--         bg = "None"
--     })
-- 
--     --hl("Normal", {
--     --    bg = "none"
--     --})
-- 
--     hl("LineNr", {
--         fg = "#5eacd3"
--     })
-- 
--     hl("netrwDir", {
--         fg = "#5eacd3"
--     })
-- 
-- end

--vim.api.nvim_create_user_command('SetColorScheme', 
--    function(scheme)
--        if scheme.args == "dark" or scheme.args == "Dark" then
--            DarkScheme()
--        elseif scheme.args == "light" or scheme.args == "Light" then
--            LightScheme()
--        else
--            print("Invalid color scheme selection: ", scheme.args)
--        end
--    end,
--    { nargs = 1 }
--)

--- Default to dark scheme
-- DarkScheme()

vim.cmd "colorscheme catppuccin"
