require("scylet.set")
require("scylet.remap")

-- DO NOT INCLUDE THIS
vim.opt.rtp:append("~/personal/streamer-tools")
-- DO NOT INCLUDE THIS

local augroup = vim.api.nvim_create_augroup
local TheScyletGroup = augroup('TheScylet', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = TheScyletGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({"BufWritePost"}, {
    group =TheScyletGroup,
    pattern = "*.py",
    callback = function()
        vim.cmd("silent !black --quiet %")
        vim.cmd("edit")
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
