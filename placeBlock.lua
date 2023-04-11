local loopValue = 0
while true do
    io.write("[" .. loopValue .. "]")
    turtle.forward()
    local blockBool  = turtle.detect()
    if not blockBool then
        print("placing wood")
        turtle.place()
    else
        print("no need for block placing")
    end
    loopValue = loopValue + 1
    turtle.back()
    sleep(600)
end