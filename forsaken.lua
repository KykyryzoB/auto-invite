if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat wait()
until game.Players.LocalPlayer.Character
wait(1)
game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("кто хочет на ру сервер фарсакен пиши мне в лс Inet_4 или нажми F9 и в конце будет ссылка")
wait(1)

local text = "\n\n\n                                   🤗НАШ \n                               ✅СЕРВЕР \n                            🥭ТУТ \n                              🔥👉 discord.gg/WznZtMrbh8 👈🔥 -- НАШ ЛУЧШИЙ СЕРВЕР\n\n\n"
 
local local_player = game:GetService("Players").LocalPlayer
local animate = local_player.Character.Animate
local idle_anim = animate.idle.Animation1
 
local old_animid = idle_anim.AnimationId
animate.Enabled = true
idle_anim.AnimationId = "active://" .. text -- text here, dont delete the activate://
task.wait()
animate.Enabled = false
animate.Enabled = true
idle_anim.AnimationId = old_animid
task.wait()
animate.Enabled = false
animate.Enabled = true

wait(2)

PlaceId, JobId = game.PlaceId, game.JobId
HttpService = game:GetService("HttpService")
TeleportService = game:GetService("TeleportService")
function servhop()
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
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
    else
        return servhop()
    end
end
servhop()
