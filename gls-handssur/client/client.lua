-- CONFIG

local cfg = {
   enable_notify = true,

   lang = 'en', -- en or ro

   notify = {
      customNotify = true, -- true or false
      exportName = 'mythic_notify', -- mythic_notify or okokNotify
      resourceName = 'gls-notify', -- notify resource name
   },

   deffault_binds = {
      hands = 'X',
      surrender = 'F9',
   },

   okokNotify = {
      time = 5000
   }
}
-- LANG

local lang = {
   en = {
      message = 'You knelt down, to get up press %s' -- don't touch %s
   },
   ro = {
      message = 'Te-ai pus in genunchi, apasa %s pentru a te ridica.' -- don't touch %s
   }
}

-- SCRIPT

local handsStatus = false
local surrenderStatus = false

local function RequestAndWaitForAnimDict(dict)
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
      Citizen.Wait(100)
   end
end

local function check(ped)
   if not IsEntityDead(ped) and not IsPedDeadOrDying(ped) and not IsPlayerFreeAiming(ped) and not IsPedAimingFromCover(ped) and not IsPedSwimming(ped) and not IsPedShooting(ped) and not IsPedClimbing(ped) and not IsPedCuffed(ped) and not IsPedDiving(ped) and not IsPedFalling(ped) and not IsPedJumping(ped) and not IsPedJumpingOutOfVehicle(ped) and IsPedOnFoot(ped) and not IsPedRunning(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedSprinting(ped) then
      return true
   else
      return false
   end
end

function hands(bool)
   local ped = PlayerPedId()

   local dict = 'missminuteman_1ig_2'

   if check(ped) then
      if bool then
         RequestAndWaitForAnimDict(dict)
         TaskPlayAnim(ped, dict, 'handsup_enter', 8.0, 8.0, -1, 50, 0, false, false, false)
         handsStatus = true
      else
         ClearPedTasks(ped)
         handsStatus = false
      end
   end
end

function surrender(bool)
   local ped = PlayerPedId()

   local dict = 'random@arrests'

   if check(ped) == true then
      if bool then
         RequestAndWaitForAnimDict(dict)
         TaskPlayAnim( ped, dict, "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
         surrenderStatus = true
         if cfg.enable_notify then
            if cfg.lang == 'en' then
               if cfg.notify.customNotify then
                  if cfg.notify.exportName == 'mythic_notify' then
                     exports[cfg.notify.resourceName]:DoLongHudText('inform', lang.en.message:format(cfg.deffault_binds.surrender), { ['background-color'] = '#470ad2', ['color'] = '#ffffff' })
                  elseif cfg.notify.exportName == 'okokNotify' then
                     exports[cfg.notify.resourceName]:Alert('Info', lang.en.message:format(cfg.deffault_binds.surrender), cfg.okokNotify.time, 'info')
                  end
               else
                  AddTextEntry("NOTIFY", lang.en.message:format(cfg.deffault_binds.surrender))
                  SetNotificationTextEntry("NOTIFY")
                  DrawNotification(true, false)
               end

            elseif cfg.lang == 'ro' then
               if cfg.notify.customNotify then
                  if cfg.notify.exportName == 'mythic_notify' then
                     exports[cfg.notify.resourceName]:DoLongHudText('inform', lang.ro.message:format(cfg.deffault_binds.surrender), { ['background-color'] = '#470ad2', ['color'] = '#ffffff' })
                  elseif cfg.notify.exportName == 'okokNotify' then
                     exports[cfg.notify.resourceName]:Alert('Info', lang.ro.message:format(cfg.deffault_binds.surrender), cfg.okokNotify.time, 'info')
                  end
               else
                  AddTextEntry("NOTIFY", lang.ro.message:format(cfg.deffault_binds.surrender))
                  SetNotificationTextEntry("NOTIFY")
                  DrawNotification(true, false)
               end
            else
               Citizen.CreateThread(function()
                  while true do
                     Citizen.Wait(60000*3)
                     print('^6HandsSur^7 ^6ERROR^7: cfg.lang is empty')
                  end
               end)
            end
         end
      else
         ClearPedTasks(ped)
         surrenderStatus = false
      end
   end
end

RegisterCommand('surrender', function()
   surrender(not surrenderStatus)
end)

RegisterCommand('handsup', function()
   hands(not handsStatus)
end)

RegisterKeyMapping('handsup', 'Toggle Hands Up', 'KEYBOARD', cfg.deffault_binds.hands)
RegisterKeyMapping('surrender', 'Toggle Surrender', 'KEYBOARD', cfg.deffault_binds.surrender)

print("[ Hands-Up Script Loaded ] -- ^1By: FireF0RX#6598 \n Discord: https://dsc.gg/fvmarket")
