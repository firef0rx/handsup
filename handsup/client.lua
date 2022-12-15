local status = false

local function toggleHandsUp(bool)
   local dict = "missminuteman_1ig_2"

   local ped = PlayerPedId()

   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
     Citizen.Wait(100)
   end

   if not IsPedSwimming(ped) and not IsPedShooting(ped) and not IsPedClimbing(ped) and not IsPedCuffed(ped) and not IsPedDiving(ped) and not IsPedFalling(ped) and not IsPedJumping(ped) and not IsPedJumpingOutOfVehicle(ped) and IsPedOnFoot(ped) and not IsPedRunning(ped) and not IsPedUsingAnyScenario(ped) and not IsPedInParachuteFreeFall(ped) then
      if bool then
         TaskPlayAnim(ped, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
         status = true
      else
         ClearPedTasks(ped)
         status = false
      end
   end
end

RegisterCommand("+handsup", function()
   toggleHandsUp(not status)
end)

RegisterKeyMapping('+handsup', "Hands-Up", "KEYBOARD", "X")