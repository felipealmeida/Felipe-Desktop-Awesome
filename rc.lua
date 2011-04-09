
-- Standard awesome library
require("awful")

require("tags")
require("emacs")
require("firefox")
require("im")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

awful.tag.viewonly(tags.tags['dev'])

keys = {}
keys = awful.util.table.join(keys
                             , awful.key({ modkey }, "w",
                                         function ()
                                            awful.tag.viewonly(tags.tags['web'])
                                         end)
                             , awful.key({ modkey }, "d",
                                         function ()
                                            awful.tag.viewonly(tags.tags['dev'])
                                         end)
                             , awful.key({ modkey }, "i",
                                         function ()
                                            awful.tag.viewonly(tags.tags['im'])
                                         end)
                             , awful.key({ modkey }, "t",
                                         function()
                                            awful.util.spawn('gnome-terminal') 
                                         end)
                             , awful.key({ modkey, "Shift" }, "q", awesome.quit)
                          )
root.keys(keys);

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

client.add_signal("manage", function (c, startup)
    c:keys(clientkeys)
end)

wibox = awful.wibox({ position = 'top', screen = 1, height = 33 })
wibox.widgets = { widget({ type = 'systray' })}

awful.util.spawn_with_shell('gnome-settings-daemon')
awful.util.spawn_with_shell('dex -a')
awful.util.spawn_with_shell('emacs')
awful.util.spawn_with_shell('firefox')
awful.util.spawn_with_shell('pidgin')
awful.util.spawn_with_shell('skype')
awful.util.spawn_with_shell('synergyc felipe-desktop')
