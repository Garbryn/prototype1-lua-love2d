local player = {}

PLAYER_WIDTH = 32
PLAYER_HEIGHT = 32

PLAYER_IDLE = 1
PLAYER_WALK = 2
PLAYER_SHOOT = 3

player.status = {}
player.status[PLAYER_IDLE] = {}
player.status[PLAYER_WALK] = {}
player.status[PLAYER_SHOOT] = {}

local sprites = require("sprites")

function player.load()
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player = createSprite("player_blue_armor_idle_with_gun", player.x, player.y)
    player.frame = 1
    print(player.frame)
end

function playerAnimations(dt)
    player.frame = player.frame + 2 * dt
    if player.frame >= 2 + 1 then
        player.frame = 1
    end
end

function playerControls(dt)
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
    local currentFrame = math.floor(player.frame)
    love.graphics.draw(
        player.image,
        player.listFrames[currentFrame],
        player.x,
        player.y,
        0,
        1,
        1,
        PLAYER_WIDTH / 2,
        PLAYER_HEIGHT / 2
    )

    love.graphics.circle("fill", player.x, player.y, 2)
    love.graphics.print(math.floor(player.frame))
end

return player
