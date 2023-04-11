-- Script for the display at home

function getFormattedTime()
    return textutils.formatTime(os.time(), false) .. " : "
end
local monitor = peripheral.wrap("front")
function main()
   while true do
    rednet.open("right")
    senderId,message = rednet.receive()
    monitor.write(getFormattedTime(), message.name)
    print(getFormattedTime(), message.name)
    rednet.close()
   end
end

main()