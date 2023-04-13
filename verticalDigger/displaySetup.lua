-- Script for the display at home

function getFormattedTime()
    return textutils.formatTime(os.time(), false) .. " : "
end
local monitor = peripheral.wrap("front")
function main()
    term.redirect("monitor")
   while true do
    rednet.open("right")
    senderId,message = rednet.receive()
    print(getFormattedTime(), message)
    rednet.close()
   end
end

main()