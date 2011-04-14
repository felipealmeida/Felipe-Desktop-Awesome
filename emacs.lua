
require("awful")
require("screen")
require("tags")
require("firefox")
require("debugterminal")

module(..., package.seeall)

emacs_frames = {}

client.add_signal('manage', function (c, startup)
    if(c.class == 'Emacs') then
       print ('Emacs manage handling')
       table.insert(emacs_frames, c)
       awful.placement.no_offscreen(c)
       awful.client.movetotag(tags.tags['dev'], c)
    end
 end)

client.add_signal('unmanage', function (c)
    if(c.class == 'Emacs') then
       print ('Emacs unmanage handling')
       for key, value in pairs(emacs_frames) do
          if value.window == c.window then
             emacs_frames[key] = nil
          end
       end
    end
end)

function maximize_frames()
   for key, client in ipairs(emacs_frames) do
      client:geometry (screen[1].workarea)
      client:raise()
   end
end

function split_with_firefox ()
   if emacs_frames[1] and firefox.firefox_frames[1] then
      debugterminal.log ("split_with_firefox")
      left_workarea = screen[1].workarea
      left_workarea['width'] = left_workarea['width']/2
      emacs_frames[1]:geometry(left_workarea)
      right_workarea = left_workarea
      right_workarea['x'] = right_workarea['width']
      firefox.firefox_frames[1]:geometry(right_workarea)
      if not firefox.firefox_frames[1]:isvisible() then
         awful.client.toggletag(tags.tags['dev'], firefox.firefox_frames[1])
      end
      emacs_frames[1]:raise()
      firefox.firefox_frames[1]:raise()
   end
end
