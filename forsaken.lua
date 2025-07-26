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
local PlaceId, JobId = game.PlaceId, game.JobId
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")

local function servhop()
    local servers = {}
    local req = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
    local body = HttpService:JSONDecode(req)

    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end

    if #servers > 0 then
        local success, errorMessage = pcall(function()
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
        end)
        
        if not success then
            GuiService:ClearError()
            wait(1) -- Небольшая задержка перед повторной попыткой
            servhop()
        end
    else
        wait(1) -- Небольшая задержка перед повторной попыткой
        servhop()
    end
end

servhop()
