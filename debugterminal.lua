
module(..., package.seeall)

local logfile = io.open("/home/felipe/.config/awesome.log", "w+")

function log (msg)
   logfile:write(msg .. "\n")
   logfile:flush()
end

awesome.add_signal('debug::error', function (msg)
    log ('Lua error ' .. msg)
 end)
