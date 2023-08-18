local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for k, v in ipairs(Config.locations) do
        exports['qb-target']:AddBoxZone("vote"..k, vector3(v.x, v.y, v.z), 0.4, 0.7, {
            name="vote"..k,
            heading=-182.48,
            debugPoly=false,
            minZ=v.z - 1,
            maxZ=v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "vote:openvoto",
                    icon = "fas fa-washer",
                    label = "View Tablet",
                },
            },
            distance = 3.0
        })
    end
    Wait(100)
end)

local isVotingEnabled = true

RegisterNetEvent("vote:openvoto")
AddEventHandler("vote:openvoto", function()
    lib.registerContext({
        id = 'candidatos_menu',
        title = 'Presidential Candidates',
        options = {
          {
            title = Config.name.candidate1,
            description = 'This is to know more about your candidate',
            menu = 'candidato_1',
            icon = 'bars',
            image = Config.image.candidate1,
          },
          {
            title = Config.name.candidate2,
            description = 'This is to know more about your candidate',
            menu = 'candidato_2',
            icon = 'bars',
            image = Config.image.candidate2,
          },
          {
            title = Config.name.candidate3,
            description = 'This is to know more about your candidate',
            menu = 'candidato_3',
            icon = 'bars',
            image = Config.image.candidate3,
          },
          {
              title = 'Go to vote',
              description = 'this is to select your candidate',
              arrow = true,
              icon = 'check',
              disabled = not isVotingEnabled,
              event = 'vote:openvot',
          }
        },
        {
            id = 'candidato_1',
            title = Config.name.candidate1,
            menu = 'candidatos_menu',
            options = {
                {
                    title = 'Presentation: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Proposal: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Additional: ',
                    description = 'write something related.',
                    icon = 'hand',
                  }
            }
        },
        {
            id = 'candidato_2',
            title = Config.name.candidate2,
            menu = 'candidatos_menu',
            options = {
                {
                    title = 'Presentation: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Proposal: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Additional: ',
                    description = 'write something related.',
                    icon = 'hand',
                  }
            }
        },
        {
            id = 'candidato_3',
            title = Config.name.candidate3,
            menu = 'candidatos_menu',
            options = {
                {
                    title = 'Presentation: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Proposal: ',
                    description = 'write something related.',
                    icon = 'hand',
                  },
                  {
                    title = 'Additional: ',
                    description = 'write something related.',
                    icon = 'hand',
                  }
            }
        },
      })
      lib.showContext('candidatos_menu')
      AddEventHandler("vote:openvot", function()
        local options = {
            { value = 'option1', label = Config.name.candidate1, image = Config.image.candidate1, },
            { value = 'option2', label = Config.name.candidate2, image = Config.image.candidate2, },
            { value = 'option3', label = Config.name.candidate3, image = Config.image.candidate3, },
        }
        local input = lib.inputDialog('Presidential Election', {
            { type = 'select', label = 'Candidates', description = 'Select your candidate', options = options, icon = 'bars', required = true },
            { type = 'checkbox', label = "You're sure?", required = true}
        })
        if input and input[1] then
            local selectedOption = nil
			local selectedImage = nil
            for _, option in ipairs(options) do
                if option.value == input[1] then
                    selectedOption = option.label
					selectedImage = option.image
                    break
                end
            end
            if selectedOption then
                print(json.encode(input))
                TriggerServerEvent('vote:discord',selectedOption,selectedImage)
                QBCore.Functions.Notify("You have selected: " .. selectedOption, "success")
                isVotingEnabled = false
            else
                QBCore.Functions.Notify("Invalid option.", "error")
            end
        end
    end)
end)