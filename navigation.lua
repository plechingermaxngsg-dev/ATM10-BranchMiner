---------------------------------------------------
-- ATM10 Branch Miner
-- Navigation System v0.2.0
---------------------------------------------------

local nav = {}

nav.x = 0
nav.y = 0
nav.z = 0

-- 0 = Nord
-- 1 = Ost
-- 2 = Süd
-- 3 = West
nav.dir = 0


---------------------------------------------------
-- Speichern
---------------------------------------------------

function nav.save()

    local file = fs.open("position.dat","w")

    file.write(
        textutils.serialize({
            x = nav.x,
            y = nav.y,
            z = nav.z,
            dir = nav.dir
        })
    )

    file.close()

end



---------------------------------------------------
-- Laden
---------------------------------------------------

function nav.load()

    if fs.exists("position.dat") then

        local file = fs.open("position.dat","r")

        local data =
            textutils.unserialize(
                file.readAll()
            )

        file.close()

        nav.x = data.x
        nav.y = data.y
        nav.z = data.z
        nav.dir = data.dir

    end

end



---------------------------------------------------
-- Drehen
---------------------------------------------------

function nav.turnLeft()

    turtle.turnLeft()

    nav.dir = (nav.dir - 1) % 4

    nav.save()

end



function nav.turnRight()

    turtle.turnRight()

    nav.dir = (nav.dir + 1) % 4

    nav.save()

end



---------------------------------------------------
-- Vorwärts
---------------------------------------------------

function nav.forward()

    while turtle.detect() do
        turtle.dig()
        sleep(0.2)
    end


    while not turtle.forward() do
        turtle.attack()
        sleep(0.2)
    end


    if nav.dir == 0 then
        nav.z = nav.z - 1

    elseif nav.dir == 1 then
        nav.x = nav.x + 1

    elseif nav.dir == 2 then
        nav.z = nav.z + 1

    elseif nav.dir == 3 then
        nav.x = nav.x - 1

    end


    nav.save()

end



---------------------------------------------------
-- Hoch / Runter
---------------------------------------------------

function nav.up()

    while turtle.detectUp() do
        turtle.digUp()
    end

    turtle.up()

    nav.y = nav.y + 1

    nav.save()

end



function nav.down()

    while turtle.detectDown() do
        turtle.digDown()
    end

    turtle.down()

    nav.y = nav.y - 1

    nav.save()

end



return nav
