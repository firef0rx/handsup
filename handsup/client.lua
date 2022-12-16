-- Author: F1reF0RX

local status = false
local surrenderStatus = false

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

local function surrender(bool)
   local ped = PlayerPedId()

   local dict = "random@arrests"

   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
     Citizen.Wait(100)
   end

   if not IsEntityDead(ped) then
      if bool then
         exports['mythic_notify']:DoHudText('inform', 'You knelt down, to get up press F9', { ['background-color'] = '#470ad2', ['color'] = '#ffffff' })
         TaskPlayAnim( ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
         surrenderStatus = true
      else
         ClearPedTasks(ped)
         surrenderStatus = false
      end
   end
end

RegisterCommand("+surrender", function()
   surrender(not surrenderStatus)
end)

RegisterCommand("+handsup", function()
   toggleHandsUp(not status)
end)

RegisterKeyMapping('+surrender', "Toggle Surrender", "KEYBOARD", "F9")
RegisterKeyMapping('+handsup', "Toggle Hands Up", "KEYBOARD", "X")

print("[ Hands-Up Script Loaded ] -- ^1By: FireF0RX#6598 \n Discord: https://dsc.gg/gliese")