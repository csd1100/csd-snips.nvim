local utils = require('csd-snips.utils')
local generators = require('csd-snips.generators')
local M = {}

M.enabled = false

-- TODO: setup function
M.setup = function(config)
	M.enabled = true
	config = config
	-- TODO: logger level config
	-- TODO: mapping config
end

M.write_debug_line = function ()
    -- TODO: debug line at cursor
    --
    -- input
    -- generate string
    -- write_to_buffer
end

M.write_to_console = function ()
    -- TODO: console log
    --
    -- add console substring
    -- write_to_buffer
    -- move cursor inside
end

M.write_to_logger = function ()
    -- TODO: logger
    --
    -- add logger substring
    -- write_to_buffer
    -- move cursor inside
end

M.debug_to_console = function ()
    utils.get_input('Enter comma separated vars to print: ', generators.debug_to_console)
end

M.debug_to_logger = function ()
    utils.get_input('Enter comma separated vars to print: ', generators.debug_to_logger)
end

M.debug_string_to_console = function ()
    -- TODO: console log string representation
end

M.debug_string_to_logger = function ()
    -- TODO: logger string representation
end

M.debug_to_specified_logger = function ()
    -- TODO: logger with object specified
end

return M
