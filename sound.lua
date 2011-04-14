
require("awful")
require("screen")
require("tags")
require("debugterminal")

module(..., package.seeall)

music_textbox = widget({ type = 'textbox' })
music_textbox.text = 'Start some music already!'

rhythmbox_clients = {}

client.add_signal('manage', function (c, startup)
    if c.class == 'Rhythmbox' then
       table.insert(rhythmbox_clients, c)
       awful.client.movetotag(tags.tags['sound'], c)
       c:geometry (screen[1].workarea)
    end
 end)

client.add_signal('unmanage', function (c)
    if c.class == 'Rhythmbox' then
       client_algos.remove_client(rhythmbox_clients, c)
    end
 end)

function refresh_music ()
   music_textbox.text = awful.util.pread('rhythmbox-client --print-playing')
end
