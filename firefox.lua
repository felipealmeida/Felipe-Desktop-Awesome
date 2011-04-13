
require ("awful")
require ("tags")

firefox_frames = {}

client.add_signal('manage', function (c, startup)
   if(c.class == 'Firefox') then
       if not c.size_hints.user_position and not c.size_hints.program_position then
          table.insert(firefox_frames, c)
          awful.placement.no_offscreen(c)
       end
       awful.client.movetotag(tags.tags['web'], c)
    end
 end)

client.add_signal('unmanage', function (c)
    if c.class == 'Firefox' then
       for key, value in pairs(firefox_frames) do
          if value.window == c.window then
             firefox_frames[key] = nil
          end
       end
    end
 end)
