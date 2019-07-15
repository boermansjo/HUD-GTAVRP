------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local AutoSaveHungerThirst = true             -- Boolean to update hunger / thirst
local AutoSaveHungerThirstTimer = 138000      -- Value in ms. Currently set to 2min30
local showHud = true                          -- Boolean to show / hide HUD
local factorFaim = (1000 * 100) / 2400000     -- Ratio to consume hunger's bar
local factorSoif = (1000 * 100) / 1800000     -- Ratio to consume thirst's bar
local faim                                    -- Init hunger's variable. Set to 100 for development. 
local soif                                    -- Init thirst's variable. Set to 100 for development. 

------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

function updateHungerThirstHUD(faim, soif)
  SendNUIMessage({
    update = true,
    faim = faim,
    soif = soif
  })
end

-- Get speed velocity while Ped is running
function getSpeed()
  local vx,vy,vz = table.unpack(GetEntityVelocity(GetPlayerPed(-1)))
  return math.sqrt(vx*vx+vy*vy+vz*vz)
end

function updateHungerThirst()
  Citizen.Wait(1000) -- Every 1sec
  local ped = GetPlayerPed(-1)

  -- If no more hunger
  if faim <= 0 then
    faim = 0
    -- Choose whatever you want to do right here (dizzy spell, loss of consciousness…)
  end

  -- If no more thirst
  if soif <= 0 then
    soif = 0
    -- Choose whatever you want to do right here (dizzy spell, loss of consciousness…)
  end

  -- Increase hunger / thirst if running
  if IsPedOnFoot(ped) then
    local x = math.min(getSpeed(),10) + 1
    if IsPedInMeleeCombat(ped) then           -- If Ped is using his fist, it consumes more hunger + thirst than while running
      x = x + 10
      faim = faim - (factorFaim * x)
      soif = soif - (factorSoif * x)
    else                                      -- If Ped running
      faim = faim - (factorFaim * x)
      soif = soif - (factorSoif * x)
    end
  else
    faim = faim - factorFaim
    soif = soif - factorSoif
  end
end

function RequestToSave()
  TriggerServerEvent("saveHungerThirst", faim, soif)
end


------------------------------------------------------------------
--                          Events
------------------------------------------------------------------

-- Get player's hunger+thirst after connecting to sync with HUD
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("getPlayerHungerThirst")
end)

-- Hunger Thirst
RegisterNetEvent("PlayerHungerThirst")
AddEventHandler("PlayerHungerThirst", function(result)
  faim = result[1].faim
  soif = result[1].soif
end)

-- Update value if used from inventory
RegisterNetEvent("UpdateFoodDrink")
AddEventHandler("UpdateFoodDrink", function(newFaim, newSoif)
  faim = faim + newFaim
  soif = soif + newSoif

  if faim > 100 then faim = 100 end
  if soif > 100 then soif = 100 end
end)

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------

-- Show HUD
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if showHud then
        updateHungerThirstHUD(faim, soif)
      end
    end
end)

-- Update hunger and thirst
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
      updateHungerThirst()
    end
end)

-- Autosave hunger and thirst
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if AutoSaveHungerThirst then
        Citizen.Wait(AutoSaveHungerThirstTimer)
        RequestToSave()
      end
    end
end)