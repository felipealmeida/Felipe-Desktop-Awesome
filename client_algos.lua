
module(..., package.seeall)

function remove_client (table, client)
   for key, value in pairs(table) do
      if client.window == value.window then
         table[key] = nil
      end
   end
end
