
require("awful")
require("screen")
require("tags")

module(..., package.seeall)

im_windows = {}
pidgin_conversations = {}
pidgin_buddy_lists = {}
skype_buddy_lists = {}
skype_conversations = {}

client.add_signal('manage', function (c, startup)
       print ('window class ' .. c.class)
       print ('window name ' .. c.name)
       print ('window type ' .. c.type)
       if c.role then
          print ('window role ' .. c.role)
       end
       print ('window instance ' .. c.instance)
    if c.class == 'Pidgin' then                               
       if c.role == 'conversation' then
          table.insert(pidgin_conversations, c)
       elseif c.role == 'buddy_list' then
          table.insert(pidgin_buddy_lists, c)
       end
       table.insert(im_windows, c)
       awful.client.movetotag(tags.tags['im'], c)
    elseif c.class == 'Skype' then
       if string.find(c.name, "Skype%A+Chat") then
          print ("Found a chat window")
          table.insert(skype_conversations, c)
       elseif string.find(c.name, "Skype.+ for Linux") then
          print ("Found a buddy list")
          table.insert(skype_buddy_lists, c)
       end
       table.insert(im_windows, c)
       awful.client.movetotag(tags.tags['im'], c)
    end
end)

