local player = {}

local SpritesManager = require("SpritesManager")
local ShootManager = require("ShootManager")

function player.load()
    player = CreateSprites("player", screenWidth / 2, screenHeight / 2, 100)
end

function PlayerController(dt)
    if love.keyboard.isDown("right") and player.x + player.width / 2 <= screenWidth then
        player.x = player.x + (player.speed * dt)
    elseif love.keyboard.isDown("down") and player.y + player.height / 2 <= screenHeight then
        player.y = player.y + (player.speed * dt)
    elseif love.keyboard.isDown("left") and player.x - player.width / 2 >= 0 then
        player.x = player.x - (player.speed * dt)
    elseif love.keyboard.isDown("up") and player.y - player.height / 2 >= 0 then
        player.y = player.y - (player.speed * dt)
    end
end

function love.mousepressed(x, y, button)
    local speed = 150
    local angle = math.angle(player.x, player.y, x, y)

    CreateShoot(player.x, player.y, speed, angle)
end

return player
