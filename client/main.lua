-- Code
local QBCore = exports['qb-core']:GetCoreObject()

local washing = false
local timer = 0
local collect = false
local washer = 0

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local inRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local time = math.random(3000, 5000)

        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, true) < 0.5 then
            inRange = true
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, true) < 1.0 then
                if not washing and not collect then
                    DrawText3Ds(washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, "~g~E~w~ - Start Washer")
                    if IsControlJustReleased(1, 38) then
                       TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
                       exports.rprogress:Start('Checking For Inky Packs...', time)
                       TriggerServerEvent('moneywash:server:checkInv')
                       ClearPedTasks(ped) 
                       washer = 1
                    end
                end
            end
        end

        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, true) < 0.5 then
            inRange = true
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, true) < 1.0 then
                if not washing and not collect then
                    DrawText3Ds(washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, "~g~E~w~ - Start Washer")
                    if IsControlJustReleased(1, 38) then
                        TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
                        exports.rprogress:Start('Checking For Inky Packs...', time)
                        TriggerServerEvent('moneywash:server:checkInv')
                        ClearPedTasks(ped)
                        washer = 2
                    end
                end
            end
        end

        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, true) < 0.5 then
            inRange = true
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, true) < 1.0 then
                if not washing and not collect then 
                    DrawText3Ds(washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, "~g~E~w~ - Start Washer")
                    if IsControlJustReleased(1, 38) then
                        TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
                        exports.rprogress:Start('Checking For Inky Packs...', time)
                        TriggerServerEvent('moneywash:server:checkInv')
                        ClearPedTasks(ped)
                        washer = 3
                    end
                end
            end
        end

        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, true) < 0.5 then
            inRange = true
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, true) < 1.0 then
                if not washing and not collect then
                    DrawText3Ds(washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, "~g~E~w~ - Start Washer")
                    if IsControlJustReleased(1, 38) then
                        TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
                        exports.rprogress:Start('Checking For Inky Packs...', time)
                        TriggerServerEvent('moneywash:server:checkInv')
                        ClearPedTasks(ped)   
                        washer = 4
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('moneywash:client:washTimer', function()
    Citizen.Wait(0)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inRange = false

    while washing do
        if washer == 1 then
            washCoordX = washLocations.pOne.x
            washCoordY = washLocations.pOne.y
            washCoordZ = washLocations.pOne.z
        elseif washer == 2 then
            washCoordX = washLocations.pTwo.x
            washCoordY = washLocations.pTwo.y
            washCoordZ = washLocations.pTwo.z
        elseif washer == 3 then
            washCoordX = washLocations.pThree.x
            washCoordY = washLocations.pThree.y
            washCoordZ = washLocations.pThree.z
        elseif washer == 4 then
            washCoordX = washLocations.pFour.x
            washCoordY = washLocations.pFour.y
            washCoordZ = washLocations.pFour.z
        end
        Citizen.Wait(0)
        DrawText3Ds(washCoordX, washCoordY, washCoordZ, "Time left on washer: " .. timer .. ' seconds.')
    end
end)

function collectMoney(amt, worth)
    Citizen.CreateThread(function()

        while collect do
            if washer == 1 then
                collectCoordX = washLocations.pOne.x
                collectCoordY = washLocations.pOne.y
                collectCoordZ = washLocations.pOne.z
            elseif washer == 2 then
                collectCoordX = washLocations.pTwo.x
                collectCoordY = washLocations.pTwo.y
                collectCoordZ = washLocations.pTwo.z
            elseif washer == 3 then
                collectCoordX = washLocations.pThree.x
                collectCoordY = washLocations.pThree.y
                collectCoordZ = washLocations.pThree.z
            elseif washer == 4 then
                collectCoordX = washLocations.pFour.x
                collectCoordY = washLocations.pFour.y
                collectCoordZ = washLocations.pFour.z
            end

            local inRange = false
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            Citizen.Wait(0)
            DrawText3Ds(collectCoordX, collectCoordY, collectCoordZ, "~g~E~w~ - Collect Clean Money")

            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, collectCoordX, collectCoordY, collectCoordZ, true) < 1 then
                inRange = true
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, collectCoordX, collectCoordY, collectCoordZ, true) <
                    0.5 then
                    if IsControlJustReleased(1, 38) and inRange then
                        TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        exports.rprogress:Start('Collecting Clean Packs...', math.random(3000, 5000))
                        TriggerServerEvent('moneywash:server:giveMoney', amt, worth)
                        ClearPedTasks(ped) 
                       collect = false
                    end
                end
            end
        end
    end)
end

RegisterNetEvent('moneywash:client:startTimer', function(amt, worth)
    washing = true
    timer = math.ceil(2 * amt)
    if timer <= 60 then
        timer = 30
    end
    TriggerEvent('moneywash:client:washTimer')

    while washing do
        timer = timer - 1
        if timer <= 0 then
            washing = false
            collect = true
            QBCore.Functions.Notify('Your clean bills are ready to be collected.', 'success', 1000)

            collectMoney(amt, worth)
        end
        Citizen.Wait(1000)
    end
end)
