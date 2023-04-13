local tArgs = { ... }

local flowerCount = tonumber( tArgs[1] )

if #tArgs ~= 1 then
	print( "mana <row>" )
	return
end

--Drops buckets above
function suckLava()
    for i=1,15 do
        turtle.suckUp()
    end  
end

--Drops buckets below
function dumpBuckets()
    for i=1,15 do
        turtle.select(i)
        turtle.dropDown()
    end  
end

--places lava blocks
function placeLava()
    for i=1,flowerCount do
        turtle.select(i)
        turtle.place()
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
    end
end

--returns from lava block placing
function returnFromLava()
    turtle.turnLeft()
    for i=1,flowerCount do
        turtle.forward()
    end
    turtle.turnRight()
end

function showSleep()
    for i=1,402 do
        print("sleeping for " .. i .. "/402")
        sleep(1)
    end
end

function main()
    while true do
        print("starting work!!! Fire bending time")
        suckLava()
        turtle.forward()
        placeLava()
        returnFromLava()
        turtle.back()
        dumpBuckets()
        showSleep()
    end
end

main()