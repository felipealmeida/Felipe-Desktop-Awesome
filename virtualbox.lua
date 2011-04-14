
require("awful")
require("screen")
require("tags")
require("firefox")
require("debugterminal")
require("client_algos")

module(..., package.seeall)

management = {}
vbox_frames = {}

client.add_signal('manage', function (c, startup)
    if c.class == 'VirtualBox' then
       if c.group_window == 56623399 then
          table.insert(management, c)
       else
          table.insert(vbox_frames, c)
       end
       awful.client.movetotag(tags.tags['virtualbox'], c)
    end
 end)

client.add_signal('unmanage', function (c)
    if c.class == 'VirtualBox' then
       if c.group_window == 56623399 then
          client_algos.remove_client(management, c)
       else
          client_algos.remove_client(vbox_frames, c)
       end
    end
 end)
