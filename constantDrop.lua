function main()
    while true do
        for i=1,16 do
            turtle.select(i)
            turtle.drop()
        end
    end
    sleep(1)
end
main()