-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("emacs")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

tags = awful.tag({ "dev", "web", 3, 4, 5, 6, 7, 8, 9 }, s, awful.layout.suit.tile)

emacs_key = awful.key({ modkey, }, "Return", function() awful.util.spawn('emacs') end)
root.keys(emacs_key);

emacs_frames = {}
firefox_frames = {}

client.add_signal("manage", function (c, startup)
    if(c.class == 'Emacs') then
       emacs_frames = c
       c.fullscreen = true
    elseif(c.class == 'Firefox') then
       if not c.size_hints.user_position and not c.size_hints.program_position then
          c.fullscreen = true
          firefox_frames = c
       end
    end
end)

awful.util.spawn_with_shell('emacs')
awful.util.spawn_with_shell('firefox')
