local ls = require('luasnip')
local types = require('luasnip.util.types')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local function split_path(path, sep)
  --local t = {}
  --for str in string.gmatch(path, "([^"..sep.."]+)") do
  --  table.insert(t, str)
  --end
  --return t
-- local result = {}
-- local regex = ("([^%s]+)"):format(sep)
-- for each in path:gmatch(regex) do
--    table.insert(result, each)
-- end
-- return result
  result = {};
  for match in (path..sep):gmatch("(.-)"..sep) do
      table.insert(result, match);
  end
  return result;
end

local function get_filename(path, sep)
  local split_path = split_path(path, sep)
  return split_path[#split_path+1]
end

ls.setup({
	history = true,
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
	store_selection_keys = "<Tab>",
	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

-- ls.add_snippets('cpp', {
--   s("/**", {
--     t({"/**", ""}),
--     t({"* @file ", ""}),  
--     t({"* @author Jacobus Lock <jacobus.lock@fox-robotics.com>", ""}),  
--     t({"* @brief ", ""}),  
--     t({"* @date ", ""}),  
--     t({"*", ""}),  
--     t({"* @copyright Fox Robotics Ltd., 2022", ""}),  
--     t({"*/", ""}),  
-- --     t(split_path(vim.api.nvim_buf_get_name(0)), '/'),
--   })
-- })
ls.add_snippets('c', {})
ls.add_snippets('py', {})
ls.add_snippets('shell', {})

ls.filetype_extend('cpp', {'cpp'})
ls.filetype_extend('c', {'cpp'})
ls.filetype_extend('py', {'python'})
ls.filetype_extend('shell', {'sh', 'bash'})

-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } }) 
require("luasnip.loaders.from_vscode").lazy_load() 
