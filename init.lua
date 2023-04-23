-- require("impatient")
require("utils.global")

-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 自动命令
require("autocmds")

-- 内置LSP
require("lsp.setup")
-- 自动补全
require("cmp.setup")
-- 格式化
require("format.setup")
-- DAP
require("dap.setup")

-- require("dap.vimspector")
-- utils
-- 复制到windows剪贴板
-- require('utils.fix-yank')

local vim_conf_files = {
    "plugins.vim", -- all the plugins installed and their configurations
}

-- source all the core config files
for _, name in ipairs(vim_conf_files) do
  local path = string.format("%s/vimconfig/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
