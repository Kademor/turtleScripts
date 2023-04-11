local Spruce = "minecraft:spruce_log"
 
function detectTree()
    return turtle.detectUp()
end
   
function initateChopping()
    turtle.dig()
    turtle.forward()
end
 
function chopLayer()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.digUp()
    turtle.up()
    turtle.turnRight()
end
 
function backDown()
    turtle.back()
    while not turtle.detectDown() do
        turtle.down();
    end
end
 
function dumpItemToRight ()
    turtle.turnRight()
    for i=1,15 do
     turtle.select(i)
     turtle.drop(64)
    end
    turtle.select(1)
    turtle.turnLeft()
end
 
function treeChoping()
    initateChopping()
    while detectTree() do
        chopLayer()
    end
    backDown()
    dumpItemToRight()
end
 
--picks fuel from the chest in the back
function refuel()
    io.write("current fuel value: ")
    print(turtle.getFuelLevel())
    if 500 > turtle.getFuelLevel() then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.suck()
        turtle.turnRight()
        turtle.turnRight()
        turtle.refuel()
    end
end
 
function main()
    while true do
        refuel()
        local containsBlock, data = turtle.inspect()
        if data.name == Spruce then
            print("its digging time")
            treeChoping()
        else
            print("no log to chop, going back to sleep")
        end
        sleep(5)
    end
end
 
main()  