
-- Standard awesome library
require("awful")
require("awful.autofocus")

require("beautiful")

require("tags")
require("emacs")
require("firefox")
require("im")

beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.border_normal = 'red'

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

awful.tag.viewonly(tags.tags['dev'])

function view_tag (tag)
   awful.tag.viewonly(tag)
   -- workarea = screen[1].workarea
   -- x_p = workarea.x + (workarea.width/2)
   -- y_p = workarea.y + (workarea.height/2)
   -- mouse.coords({x = x_p, y = y_p})
   -- c = mouse.object_under_pointer()
   -- if c then
   --    print ("There is something under the pointer " .. c.class)
   --    client.focus = c
   -- else
   --    print ("Nothing udner the pointer?")
   -- end
end

keys = {}
keys = awful.util.table.join(keys
                             , awful.key({ modkey }, "w", function () view_tag(tags.tags['web']) end)
                             , awful.key({ modkey }, "d", function () view_tag(tags.tags['dev']) end)
                             , awful.key({ modkey }, "i", function () view_tag(tags.tags['im']) end)
                             , awful.key({ modkey }, "s", function () view_tag(tags.tags['sound']) end)
                             , awful.key({ modkey }, "t",
                                         function()
                                            awful.util.spawn('gnome-terminal') 
                                         end)
                             , awful.key({ modkey, "Shift" }, "q", awesome.quit)
                             , awful.key({ modkey }, "Tab",
                                         function ()
                                            awful.client.focus.history.previous()
                                            if client.focus then
                                               client.focus:raise()
                                            end
                                         end)
                          )
root.keys(keys);

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "r",      function (c) client.focus = c; c:raise()      end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

clientbuttons = awful.button({ modkey }, 1, awful.mouse.client.move)

client.add_signal("manage", function (c, startup)
    c:keys(clientkeys)
    c:buttons(clientbuttons)
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    c:add_signal("mouse::enter", function(c)
        print ('mouse enter ' .. c.class)                                    
        if awful.client.focus.filter(c) then
           client.focus = c
        end
    end)
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

wibox = awful.wibox({ position = 'top', screen = 1, height = 30 })
wibox.widgets = { widget({ type = 'systray' })}

awful.util.spawn_with_shell('gnome-settings-daemon')
awful.util.spawn_with_shell('dex -a')
awful.util.spawn_with_shell('emacs')
awful.util.spawn_with_shell('firefox')
awful.util.spawn_with_shell('pidgin')
awful.util.spawn_with_shell('skype')
awful.util.spawn_with_shell('synergyc felipe-desktop')
