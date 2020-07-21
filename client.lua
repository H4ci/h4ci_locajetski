ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

Config              = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 0, g = 128, b = 255}
Config.Type         = 35

local position = {
        {x = -1596.89 , y = -1163.28, z = 1.96},
}  

Citizen.CreateThread(function()
     for k in pairs(position) do
        local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
        SetBlipSprite(blip, 410)
        SetBlipColour(blip, 57)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Location Jetski")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < Config.DrawDistance) then
                DrawMarker(Config.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

RMenu.Add('locajetski', 'main', RageUI.CreateMenu("Location", "Jetski"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('locajetski', 'main'), true, true, true, function()

            RageUI.Button("Jetski", "Pour obtenir un jetski", {RightLabel = "~r~250$"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('h4ci:locajetski')
                local plate = exports['esx_vehicleshop']:GeneratePlate()
                VehicleLoadTimer("seashark")
                local veh = CreateVehicle("seashark",-1610.8, -1168.81, 0.59, 110.44,true,false)
				SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
				SetVehicleNumberPlateText(veh,plate)
                TriggerEvent("RS_KEY:GiveKey", plate)
                RageUI.CloseAll()
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)




    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour obtenir un ~b~jetski")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('locajetski', 'main'), not RageUI.Visible(RMenu:Get('locajetski', 'main')))
                    end   
                end
            end
        end
    end)

