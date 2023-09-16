-- https://github.com/dhananjaylatkar/cscope_maps.nvim

-- Keymaps 	Description
-- <leader>cs 	find all references to the token under cursor
-- <leader>cg 	find global definition(s) of the token under cursor
-- <leader>cc 	find all calls to the function name under cursor
-- <leader>ct 	find all instances of the text under cursor
-- <leader>ce 	egrep search for the word under cursor
-- <leader>cf 	open the filename under cursor
-- <leader>ci 	find files that include the filename under cursor
-- <leader>cd 	find functions that function under cursor calls
-- <leader>ca 	find places where this symbol is assigned a value
-- <leader>cb 	build cscope database
-- Ctrl-] 	do :Cstag <cword>
local status, cscope_maps = pcall(require, "cscope_maps")
if not status then
  vim.notify("没有找到 cscope_maps")
  return
end

cscope_maps.setup({
  -- maps related defaults
  disable_maps = false, -- "true" disables default keymaps
  skip_input_prompt = false, -- "true" doesn't ask for input

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.out",
    -- cscope executable
    exec = "cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- these args are directly passed to "cscope -f <db_file> <args>"
    -- db_build_cmd_args = { "-bqkv" },
    db_build_cmd_args = { "-Rbq" },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
  }
})
