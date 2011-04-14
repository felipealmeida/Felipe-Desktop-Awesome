
clientkeys = {}
keys = {}

-- Standard awesome library
require("awful")
require("awful.autofocus")

require("beautiful")

require('debugterminal')

require("tags")
require("emacs")
require("firefox")
require("im")
require("sound")
require("virtualbox")
require("title")

beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.border_normal = 'red'

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

awful.tag.viewonly(tags.tags['web'])

function view_tag (tag)
   awful.tag.viewonly(tag)
end

keys = awful.util.table.join(keys
                             , awful.key({ modkey }, "w", function () view_tag(tags.tags['web']) end)
                             , awful.key({ modkey }, "d"
                                         , function () 
                                              view_tag(tags.tags['dev']) 
                                              if not emacs.emacs_frames[1] == nil then
                                                 emacs.emacs_frames[1]:raise()
                                                 client.focus = emacs.emacs_frames[1]
                                              end
                                           end)
                             , awful.key({ modkey }, "i", function () view_tag(tags.tags['im']) end)
                             , awful.key({ modkey }, "s", function () view_tag(tags.tags['sound']) end)
                             , awful.key({ modkey }, "v", function () view_tag(tags.tags['virtualbox']) end)
                             , awful.key({ modkey }, "1", function () view_tag(tags.tags[1]) end)
                             , awful.key({ modkey }, "2", function () view_tag(tags.tags[2]) end)
                             , awful.key({ modkey }, "3", function () view_tag(tags.tags[3]) end)
                             , awful.key({ modkey }, "4", function () view_tag(tags.tags[4]) end)
                             , awful.key({ modkey }, "5", function () view_tag(tags.tags[5]) end)
                             , awful.key({ modkey }, "t",
                                         function()
                                            awful.util.spawn('gnome-terminal') 
                                         end)
                             , awful.key({ modkey, "Shift" }, "v", function ()
                                            awful.util.spawn('virtualbox')
                                         end)
                             , awful.key({ modkey }, "Return",
                                         function()
                                            awful.util.spawn_with_shell('nautilus --no-desktop') 
                                         end)
                             , awful.key({ modkey, "Shift" }, "q", awesome.quit)
                             , awful.key({ modkey }, "Tab",
                                         function ()
                                            awful.client.focus.history.previous()
                                            if client.focus then
                                               client.focus:raise()
                                            end
                                         end)
                             , awful.key({ modkey }, "o",
                                         function ()
                                            --local clients = awful.client.visible(1)
                                            local current_tags = awful.tag.selectedlist()
                                            local clients = {}
                                            for key, t in pairs(current_tags) do
                                               local local_clients = t:clients()
                                               for k, c in pairs(local_clients) do
                                                  table.insert(clients, c)
                                               end
                                            end

                                            local menus = {}
                                            for key, c in pairs(clients) do
                                               table.insert(menus, { c.name
                                                               , function()
                                                                    c:raise()
                                                                    client.focus = c
                                                                 end})
                                            end

                                            menu = awful.menu({ items = menus, width = 300 })
                                            menu:toggle()
                                         end)
                          )
root.keys(keys);

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
--    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
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

    if not c.size_hints.user_position and not c.size_hints.program_position then
       awful.placement.no_offscreen(c)
    end

    c:add_signal("mouse::enter", function(c)
        if awful.client.focus.filter(c) then
           client.focus = c
        end
    end)
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

wibox = awful.wibox({ position = 'top', screen = 1, height = 30 })

wibox.widgets = { 
   {
      title.title_textbox,
      layout = awful.widget.layout.horizontal.leftright,
   },
   awful.widget.textclock({ align = "right" }),
   widget({ type = 'systray' }),
   layout = awful.widget.layout.horizontal.rightleft,
}

awful.util.spawn_with_shell('dex -a')
awful.util.spawn_with_shell('emacs')
awful.util.spawn_with_shell('firefox')
awful.util.spawn_with_shell('pidgin')
awful.util.spawn_with_shell('skype')

pcall(function () require("local") end)

