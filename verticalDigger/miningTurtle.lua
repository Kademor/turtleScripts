-- Script for the main mining turtle

local CHUNK_LOADING_TURTLE = 6
local MASTER_COMPUTER_ID = 22
-- Setup next mining
-- Slot 1 ender chest, 
-- Slot 2 dimensinal receiver, 
-- Slot 3 miner, 
-- Slot 4 boosters(x3), 
-- Slot 5 chunk loader 
function setupMining()
    clearMining()
    turtle.down()
    turtle.select(2)
    turtle.place()
    turtle.up()
    turtle.select(3)
    turtle.place()
    turtle.select(4)
    for i =3,1,-1
    do
        turtle.up()
        turtle.place()
    end
    turtle.up()
    turtle.select(5)
    turtle.place()
    for i =4,1,-1
    do
        turtle.down()
    end
    turtle.select(1)
    turtle.placeDown()
    unload()
end

-- Unloads all items except last slot
function unload()
	print( "Unloading items..." )
	for n=1,15 do
		local nCount = turtle.getItemCount(n)
        turtle.select(n)	
        turtle.dropDown()		
	end
	turtle.select(1)
end

-- Clear Mining
function clearMining()
    -- breaks ender chest and gets ito position
    turtle.digDown()
    turtle.down()
    turtle.dig()
    for i =5,1,-1
    do
        turtle.up()
        turtle.dig()
    end
    for i =4,1,-1
    do
        turtle.down()
    end
end

local blocksToClimb = 0;
function lowerTurtleUntilBlockIsFound()
    blocksToClimb = 0; 
    local success, data = turtle.inspectDown()
    while (not success) do
        turtle.down()
        success, data = turtle.inspectDown()
        blocksToClimb = blocksToClimb + 1
    end
end

function relocate()
    location = gps.locate()
    local x, y, z = gps.locate()
    -- Return to y position 170
    for i = 170-y,1,-1
    do
       turtle.up()
    end
    refuel()
    -- Move forwards
    for i =16,1,-1
    do
       turtle.forward()
    end
end

-- Gets items from miner, returns true if still has items
function getItemsFromMiner()
    print(getFormattedTime(), "getting items from miner...")
    turtle.suck()
    itemCount = turtle.getItemCount(1)
    if (itemCount == 0) then
        return false;
    else
        print(getFormattedTime(), turtle.getItemDetail().name)
        rednet.open("left")
        rednet.send(7, "(" .. os.getComputerLabel() .. ") : " .. turtle.getItemDetail())
        rednet.close()
        turtle.dropDown()
        return true;
    end
end

function refuel()
    turtle.select(16)
    turtle.place()
    turtle.suck()
    turtle.refuel()
    turtle.drop()
    turtle.dig()
    turtle.select(1)
end

function getFormattedTime()
    return textutils.formatTime(os.time(), false) .. " : "
end

-- Sends chunk loading turtle to place itself
function sendMiningFinishedUpdate()
    rednet.open("left")
    rednet.send(CHUNK_LOADING_TURTLE, "Message to relocate chunk loading ward")
    rednet.close()
end

-- Listens to call to it's rednet id to restart mining
function awaitReadyToRestart()
    rednet.open("left")
    rednet.receive()
    rednet.close()
end

-- 10 mins
local TIMER_DURATION = 600;
-- Timer fonction
function startMining ()
    local delay = 0;
    print("starting mining")
    repeat
      local foundItems = getItemsFromMiner()
      if (foundItems) then
        timer = os.startTimer(TIMER_DURATION)
        delay = 0
      else
        delay = delay + 1
      end
      sleep(1)
    until delay == TIMER_DURATION
end

function sendCurrentPositonToMaster()
    rednet.open("left")
    rednet.send(MASTER_COMPUTER_ID, "(" .. os.getComputerLabel() .. ")".. "Location : " .. gps.locate())
    rednet.close()
end

function getComputerLabe

function main() 
    while true do
        sendCurrentPositonToMaster()
        lowerTurtleUntilBlockIsFound()
        setupMining()
        startMining()
        sendMiningFinishedUpdate()
        awaitReadyToRestart()
        clearMining()
        relocate()
    end
end

main()