
require("awful")
require("screen")
require("tags")

module(..., package.seeall)

emacs_frames = {}

for key, value in pairs(tags.tags) do
   print ('[' .. key  .. '] ')
end

client.add_signal('manage', function (c, startup)
    if(c.class == 'Emacs') then
       print ('Emacs manage handling')
       table.insert(emacs_frames, c)
       awful.placement.no_offscreen(c)
       awful.client.movetotag(tags.tags['dev'], c)
    end
 end)


function maximize_frames()
   for key, client in ipairs(emacs_frames) do
      client:geometry (screen[1].workarea)
   end
end
