
require("awful")
require("screen")
require("tags")
require("client_algos")

module(..., package.seeall)

im_windows = {}
pidgin_conversations = {}
pidgin_buddy_lists = {}
skype_buddy_lists = {}
skype_conversations = {}

local function is_skype_conversation (client)
   return string.find(client.name, "Skype%A+Chat")
end

local function is_skype_buddy_list (client)
   return string.find(client.name, "Skype.+ for Linux")
end

client.add_signal('manage', function (c, startup)
    if c.class == 'Pidgin' then                               
       if c.role == 'conversation' then
          table.insert(pidgin_conversations, c)
       elseif c.role == 'buddy_list' then
          table.insert(pidgin_buddy_lists, c)
       end
       table.insert(im_windows, c)
       awful.client.movetotag(tags.tags['im'], c)
    elseif c.class == 'Skype' then
       if is_skype_conversation(c) then
          print ("Found a chat window")
          table.insert(skype_conversations, c)
       elseif is_skype_buddy_list(c) then
          print ("Found a buddy list")
          table.insert(skype_buddy_lists, c)
       end
       table.insert(im_windows, c)
       awful.client.movetotag(tags.tags['im'], c)
    end
end)

client.add_signal('unmanage', function (c)
    if c.class  == 'Pidgin' then
       if c.role == 'conversation' then
          client_algos.remove_client (pidgin_conversations, c)
       elseif c.role == 'buddy_list' then
          client_algos.remove_client (pidgin_buddy_lists, c)
       end
       client_algos.remove_client (im_windows, c)
    elseif c.class == 'Skype' then
       if is_skype_conversation(c) then
          client_algos.remove_client(skype_conversations, c)
       elseif is_skype_buddy_list(c) then
          client_algos.remove_client(skype_buddy_lists, c)
       end
       client_algos.remove_client(im_windows, c)
    end
 end)
