local status = false

local function toggleHandsUp(bool)
    local ped = PlayerPedId()
    if not IsPedSwimming(ped) and not IsPedShooting(ped) and not IsPedClimbing(ped) and not IsPedCuffed(ped) and not IsPedDiving(ped) and not IsPedFalling(ped) and not IsPedJumping(ped) and not IsPedJumpingOutOfVehicle(ped) and IsPedOnFoot(ped) and not IsPedRunning(ped) and not IsPedUsingAnyScenario(ped) and not IsPedInParachuteFreeFall(ped) then
        local dict = "missminuteman_1ig_2"
        if bool then
            if not status then
                RequestAndWaitForAnimDict(dict)
                TaskPlayAnim(ped, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                status = true
            end
        else
            ClearPedTasks(ped)
            status = false
        end
    end
end

local function surrender(bool)
    local ped = PlayerPedId()
    if not IsEntityDead(ped) then
        local dict = "random@arrests"
        if bool then
            if not status then
                RequestAndWaitForAnimDict(dict)
                exports['mythic_notify']:DoHudText('inform', 'You knelt down, to get up press F9', { ['background-color'] = '#470ad2', ['color'] = '#ffffff' })
                TaskPlayAnim(ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                status = true
            end
        else
            ClearPedTasks(ped)
            status = false
        end
    end
end

function RequestAndWaitForAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
end

RegisterCommand("+surrender", function()
    surrender(not status)
end)

RegisterCommand("+handsup", function()
    toggleHandsUp(not status)
end)

RegisterKeyMapping('+
