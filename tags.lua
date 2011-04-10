
require ("awful")

module(..., package.seeall)

print ("creating tags")

tags_names = { "web", "dev", "im", "sound", 5, 6, 7, 8, 9 }
all_tags = awful.tag(tags_names, nil, nil)

tags = {}
for key, value in ipairs(all_tags) do
   tags[tags_names[key]] = value
end

for key, value in pairs(tags) do
   print('key ' .. key)
end
