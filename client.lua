local removedExtras = false

function TurnOnExtras(vehicle, extras)
    if removedExtras == true then
        for _, v in ipairs(extras) do
            SetVehicleExtra(vehicle, v, false)
            removedExtras = false
            Wait(50)
        end
        return 
    end
end

function TurnOffExtras(vehicle, extras)
    if removedExtras == false then
        for _, v in ipairs(extras) do
            SetVehicleExtra(vehicle, v, true)
            removedExtras = true
            Wait(50)
        end
        return
    end
end

CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if IsPedInVehicle(ped, vehicle, false) then
            if IsVehicleStopped(vehicle) then
                local modelHash = GetEntityModel(vehicle)
                if Vehicles[modelHash] then
                    TurnOffExtras(vehicle, Vehicles[modelHash].drivingExtras)
                    Wait(50)
                    TurnOnExtras(vehicle, Vehicles[modelHash].parkExtras)
                end
            else
                local modelHash = GetEntityModel(vehicle)
                if Vehicles[modelHash] then
                    TurnOffExtras(vehicle, Vehicles[modelHash].parkExtras)
                    Wait(50)
                    TurnOnExtras(vehicle, Vehicles[modelHash].drivingExtras)
                end
            end
        end
    end
end)