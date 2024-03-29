local string_utils = require("csd-snips.string_utils")
local utils = require("csd-snips.utils")

local CONSOLE_LOG = "print"
local LOGGER_DEBUG = "vim.notify"

local get_var = function(var, append_to)
    local var_string = '"['
        .. var
        .. ": "
        .. '" .. '
        .. var
        .. ' .. "'
        .. ']\\n"'
    return append_to .. var_string
end

local get_var_with_notation = function(var, append_to)
    local var_string = '"['
        .. var
        .. ": "
        .. '" .. tostring('
        .. var
        .. ') .. "'
        .. ']\\n"'
    return append_to .. var_string
end

local M = {}

M.get_vars = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)
    local line = utils.reducer(vars_table, get_var, "")
    return line
end

M.get_vars_with_notation = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)
    local line = utils.reducer(vars_table, get_var_with_notation, "")
    return line
end

M.prepend_console_function = function(string_input)
    return CONSOLE_LOG .. string_input
end

M.prepend_logger_function = function(string_input)
    return LOGGER_DEBUG .. string_input
end

M.append_semicolon_if_needed = function(string_input)
    return string_input
end

return M
