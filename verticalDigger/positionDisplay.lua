local monitor = peripheral.wrap("front")
function main()
    term.redirect("monitor")
    while true do
        rednet.open("top")
        senderId,message = rednet.receive()
        print(message)
        rednet.close()
    end
end
main() 