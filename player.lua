local player = {}

PLAYER_WIDTH = 32
PLAYER_HEIGHT = 32

local sprites = require("sprites")

function player.load()
    player = createSprite("player_blue_armor_idle_with_gun", IDLE_FORWARD, 3, 4)
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
end

function player.animations(dt)
    frame = frame + 2 * dt
    if frame >= player.status[IDLE_FORWARD].frameEnd + 1 then
        frame = player.status[IDLE_FORWARD].frameStart
    end
end

function player.move(dt)
    if love.keyboard.isDown("up") and player.y >= 0 + PLAYER_HEIGHT / 2 then
        player.y = player.y - 100 * dt
    elseif love.keyboard.isDown("right") and player.x <= love.graphics.getWidth() - PLAYER_WIDTH / 2 then
        player.x = player.x + 100 * dt
    elseif love.keyboard.isDown("down") and player.y <= love.graphics.getHeight() - PLAYER_HEIGHT / 2 then
        player.y = player.y + 100 * dt
    elseif love.keyboard.isDown("left") and player.x >= 0 + PLAYER_WIDTH / 2 then
        player.x = player.x - 100 * dt
    end
end

function player.draw()
    love.graphics.draw(
        player.image,
        player.frames[math.floor(frame)],
        player.x,
        player.y,
        0,
        1,
        1,
        PLAYER_WIDTH / 2,
        PLAYER_HEIGHT / 2
    )

    love.graphics.circle("fill", player.x, player.y, 2)
    love.graphics.print(math.floor(frame))
end

return player
