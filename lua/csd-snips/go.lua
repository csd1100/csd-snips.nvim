local string_utils = require("csd-snips.string_utils")
local utils = require("csd-snips.utils")

local CONSOLE_LOG = "fmt.Printf"
local LOGGER_DEBUG = "log.Printf"

local get_var = function(var, append_to)
    local var_string = var .. ": " .. "%+v"
    return append_to
        .. string_utils.surround_with_square_brackets(var_string)
        .. "\\n"
end

local append_comma_and_var = function(var, append_to)
    return append_to .. "," .. var
end

local append_comma_and_var_notation = function(var, append_to)
    return append_comma_and_var(var, append_to)
end

local closure_param_list = function(vars_table, params_generator)
    return function(append_to)
        return utils.reducer(vars_table, params_generator, append_to)
    end
end

local M = {}

M.get_vars = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)

    local append_param_list =
        closure_param_list(vars_table, append_comma_and_var)
    local generate_message_format =
        utils.decorate_three_param_function(utils.reducer, vars_table, get_var)

    return utils.pipe({
        generate_message_format,
        string_utils.surround_with_double_quotes,
        append_param_list,
    }, "")
end

M.get_vars_with_notation = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)

    local append_param_list =
        closure_param_list(vars_table, append_comma_and_var_notation)
    local generate_message_format =
        utils.decorate_three_param_function(utils.reducer, vars_table, get_var)

    return utils.pipe({
        generate_message_format,
        string_utils.surround_with_double_quotes,
        append_param_list,
    }, "")
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

M.print_nil_check = function()
    vim.api.nvim_put({
        "if err != nil {",
        "\treturn nil,err",
        "}",
    }, "l", true, false)
    -- crude way of doing following thing
    -- 1. Select all 3 lines
    -- 2. indent the lines
    -- 3. go to 'nil'
    -- 4. enter select mode on 'nil'
    vim.api.nvim_input("Vjjj=jwwve;<C-g><C-r>_")
end

return M
