CreateThread(function()
    for Model, ModelData in pairs(Config.Chairs) do 
        exports.ox_target:addModel(Model, {{
            label = 'Sit på stol',
            icon = 'fa-solid fa-chair',
            onSelect = function(data) 
                SitOnChair(data.entity, ModelData)
            end
        }})
    end

    for Model, ModelData in pairs(Config.Beds) do 
        exports.ox_target:addModel(Model, {{
            label = 'Læg på seng',
            icon = 'fa-solid fa-bed',
            onSelect = function(data) 
                SitOnChair(data.entity, ModelData)
            end
        }})
    end
end)

function SitOnChair(object, data)
    local ped =  PlayerPedId()
	local lastPos = GetEntityCoords(ped)
    local objectcoords = GetEntityCoords(object)
	FreezeEntityPosition(object, true)
	SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + -1.4)
	FreezeEntityPosition(ped, true)
    TaskStartScenarioAtPosition(ped, 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', objectcoords.x, objectcoords.y - data.verticalOffsetY, objectcoords.z - data.verticalOffset, GetEntityHeading(object) + data.direction, 0, true, true)
    lib.showTextUI('[E] - Leave Chair', { position = "left-center", icon = 'chair' })
    CreateThread(function()
        while true do 
            Wait(0)
			if IsControlJustPressed(0, 38) then
				ClearPedTasks(ped)
				SetEntityCoords(ped, lastPos)
				FreezeEntityPosition(ped, false)
                lib.hideTextUI()
                break
			end
        end
    end)
end

function LayOnBed(object, data)
    local ped =  PlayerPedId()
	local lastPos = GetEntityCoords(ped)
    local objectcoords = GetEntityCoords(object)
    local verticalOffset = -1.4
    local direction = 0.0

	FreezeEntityPosition(object, true)
	SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + -1.4)
	FreezeEntityPosition(ped, true)
    TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', objectcoords.x, objectcoords.y, objectcoords.z - verticalOffset, GetEntityHeading(object)+direction, 0, true, true)
    lib.showTextUI('[E] - Leave Bed', { position = "left-center", icon = 'bed' })
    CreateThread(function()
        while true do 
            Wait(0)
			if IsControlJustPressed(0, 38) then
				ClearPedTasks(ped)
				SetEntityCoords(ped, lastPos)
				FreezeEntityPosition(ped, false)
                lib.hideTextUI()
                break
			end
        end
    end)
end