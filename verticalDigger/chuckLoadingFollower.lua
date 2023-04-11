-- Script for the turtle that brings a chunk loader

local TURTLE_MINER_ID = 4
-- Wait for rednet signal to start moving into cheunck
function waitToStart()
    rednet.open("left")
    senderId,message = rednet.receive()
    print("received message to go relocate")
    rednet.close()
end

-- Break setup and move forward
function relocate()
    turtle.digUp()
    for i =16,1,-1
    do
       turtle.forward()
    end
    turtle.placeUp()
end

-- Sends signal to miner to relocate
function sendReadySignal()
    rednet.open("left")
    rednet.send(TURTLE_MINER_ID, "Message to relocate miner")
    rednet.close()
end

function main()
   while true do
    waitToStart()
    relocate()
    sendReadySignal()
   end
end

main()