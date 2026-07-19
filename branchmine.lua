---------------------------------------------------
-- ATM10 Branch Miner
-- Version 0.1.0
-- CC:Tweaked Mining Turtle
---------------------------------------------------

-- Einstellungen
local MAIN_LENGTH = 200      -- Länge des Haupttunnels
local BRANCH_LENGTH = 12     -- Länge der Seitenarme
local BRANCH_SPACING = 4     -- Abstand zwischen Seitenarmen


---------------------------------------------------
-- Navigation
---------------------------------------------------

local x = 0
local y = 0
local z = 0

-- 0 = Nord
-- 1 = Ost
-- 2 = Süd
-- 3 = West
local direction = 0


local function turnLeft()
    turtle.turnLeft()
    direction = (direction - 1) % 4
end


local function turnRight()
    turtle.turnRight()
    direction = (direction + 1) % 4
end


local function updatePosition()

    if direction == 0 then
        z = z - 1

    elseif direction == 1 then
        x = x + 1

    elseif direction == 2 then
        z = z + 1

    elseif direction == 3 then
        x = x - 1
    end
end


---------------------------------------------------
-- Bewegung
---------------------------------------------------

local function digForward()

    while turtle.detect() do
        turtle.dig()
        sleep(0.2)
    end

end


local function forward()

    digForward()

    while not turtle.forward() do
        turtle.attack()
        turtle.dig()
        sleep(0.2)
    end

    updatePosition()
end



local function digUp()

    while turtle.detectUp() do
        turtle.digUp()
        sleep(0.2)
    end

end



---------------------------------------------------
-- Treibstoff
---------------------------------------------------

local function refuel()

    if turtle.getFuelLevel() > 100 then
        return
    end


    for slot = 1,16 do

        turtle.select(slot)

        if turtle.refuel(1) then

            print("Tanke auf...")
            
            while turtle.refuel(1) do
            end

            return
        end

    end


    print("Kein Treibstoff gefunden!")
end



---------------------------------------------------
-- Tunnel graben
---------------------------------------------------

local function digTunnel()

    digUp()
    forward()
    digUp()

end



---------------------------------------------------
-- Seitenarm
---------------------------------------------------

local function mineBranch()

    for i = 1, BRANCH_LENGTH do
        digTunnel()
    end


    -- zurück
    turtle.turnLeft()
    turtle.turnLeft()

    for i = 1, BRANCH_LENGTH do
        forward()
    end


    turtle.turnLeft()
    turtle.turnLeft()

end



---------------------------------------------------
-- Branch Mining
---------------------------------------------------

local function startMining()


    print("Starte Branch Mining")

    for i = 1, MAIN_LENGTH do


        refuel()

        digTunnel()


        if i % BRANCH_SPACING == 0 then


            -- links
            turtle.turnLeft()

            mineBranch()

            turtle.turnRight()



            -- rechts
            turtle.turnRight()

            mineBranch()

            turtle.turnLeft()


        end

    end

end



---------------------------------------------------
-- Rückkehr
---------------------------------------------------

local function returnHome()

    print("Kehre zurück...")


    turtle.turnLeft()
    turtle.turnLeft()


    for i = 1, MAIN_LENGTH do
        forward()
    end


    print("Fertig!")

end



---------------------------------------------------
-- Start
---------------------------------------------------

print("===================")
print(" ATM10 Branch Miner ")
print(" Version 0.1.0 ")
print("===================")


refuel()

startMining()

returnHome()
