if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game:GetService("Players").LocalPlayer.Character
task.wait(1)

-- Отправка сообщения в чат (может не работать в новых играх с новым чатом)
local success, err = pcall(function()
    game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("кто хочет на ру сервер фарсакен пиши мне в лс inet_4 или нажми F9 и в конце будет ссылка")
end)
if not success then
    warn("Не удалось отправить сообщение:", err)
end

task.wait(1)

-- Попытка "текстовой анимации" (может не работать в новых версиях Roblox)
local text = "\n\n\n                                   :hugging:НАШ \n                               :white_check_mark:СЕРВЕР \n                            :mango:ТУТ \n                              :fire::point_right: discord.gg/WznZtMrbh8 :point_left::fire: -- НАШ ЛУЧШИЙ СЕРВЕР\n\n\n"

local local_player = game:GetService("Players").LocalPlayer
if local_player.Character and local_player.Character:FindFirstChild("Animate") then
    local animate = local_player.Character.Animate
    local idle_anim = animate.idle.Animation1
    
    local old_animid = idle_anim.AnimationId
    animate.Enabled = false
    idle_anim.AnimationId = "active://" .. text
    animate.Enabled = true
    task.wait(2)
    animate.Enabled = false
    idle_anim.AnimationId = old_animid
    animate.Enabled = true
end

task.wait(2)

-- Серверный хоп
local function servhop()
    local servers = {}
    local success, response = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    end)
    
    if success then
        local data = game:GetService("HttpService"):JSONDecode(response)
        for _, v in ipairs(data.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end
        
        if #servers > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
        else
            warn("Не найдено подходящих серверов")
            return servhop()
        end
    else
        warn("Ошибка при получении списка серверов:", response)
        return servhop()
    end
end

servhop()
