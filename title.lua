
require("client")

module(..., package.seeall)

title_textbox = widget({ type = 'textbox' })
title_textbox.text = 'Should contain application title!'

client.add_signal('focus', function (c)
    title_textbox.text = c.name
 end)
