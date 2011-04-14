
module(..., package.seeall)

local home = os.getenv('HOME')
local logfile = io.open(home .. "/.config/awesome.log", "w+")

function log (msg)
   logfile:write(msg .. "\n")
   logfile:flush()
end

awesome.add_signal('debug::error', function (msg)
    log ('Lua error ' .. msg)
 end)
