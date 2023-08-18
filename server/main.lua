local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('vote:discord')
AddEventHandler('vote:discord', function(selectedOption,selectedImage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(src)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end
    local citizenid = Player.PlayerData.citizenid
    local discordaa = string.format('<@%s>', discordId)
    local hora = os.date("%d/%m/%Y %X")
	local content = {
		    {
			["color"] = '654321',
			["title"] = "** Presidential Election **",
			["description"] = '**Login: **'..citizenid..'\n**Selected candidate:** '..selectedOption..'\n**Discord:** '..discordaa,
            ["footer"] = {
                ["text"] = hora,
            },
            ["image"] = {
                ["url"] = selectedImage
            },
            ["thumbnail"] = {
                ["url"] = Config.thumbnail
            }
        }
    }
	TriggerEvent('vote:embed',content)
end)

RegisterServerEvent('vote:embed')
AddEventHandler('vote:embed', function(content)
    local webhook = Config.webhook
	PerformHttpRequest(webhook, function() end, 'POST', json.encode({embeds = content}), { ['Content-Type'] = 'application/json' })
end)