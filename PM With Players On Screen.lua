--[[
    Script Name: 		PM With Players On Screen
    Description: 		Check for players on screen and pm to other character with their names
    Author: 			Ascer - example
]]

local RECEIVER = "Cipfried"                     -- character to receive messages.
local SAFE_LIST = {"friend1", "friend2"}        -- avoid sending message with your friends
local INSTANT = true                            -- send message always or only when a new player enter on screen
local SPEAK_DELAY = 3                           -- time in seconds between sending msg.

-- DON'T EDIT BELOW THIS LINE

local storage, speakTime = {}, 0

Module.New("PM With Players On Screen", function ()
    local names, amount = "", 0
    if os.clock() - speakTime > SPEAK_DELAY then
        for i, player in pairs(Creature.iPlayers(7)) do
            if not table.find(SAFE_LIST, player.name) then
                if not INSTANT then
                    if not table.find(storage, player.name) then
                        table.insert(storage, player.name)
                        names = names .. player.name .. ", "
                        amount = amount + 1
                    end
                else
                    names = names .. player.name .. ", "
                    amount = amount + 1    
                end    
            end
        end
        if names ~= "" then
            Self.PrivateMessage(RECEIVER, "On screen (" .. amount .. ") " .. names, 3000)
            speakTime = os.clock()   
        end
    end        
end)
