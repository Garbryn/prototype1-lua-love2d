local player = {}

PLAYER_WIDTH = 32
PLAYER_HEIGHT = 32

local frame = 1

local animations = {}

local animationsStatesIdle = {
    downward = 1,
    forward = 2,
    upwards = 3,
    backwards = 4
}

animations[animationsStatesIdle.downward] = {
    first = 1,
    last = 2
}
animations[animationsStatesIdle.forward] = {
    first = 3,
    last = 4
}
animations[animationsStatesIdle.upwards] = {
    first = 5,
    last = 6
}
animations[animationsStatesIdle.backwards] = {
    first = 7,
    last = 8
}

local currentAnimation = 0

local sprites = require("sprites")

function changeAnimation(pAnimation)
    if currentAnimation ~= pAnimation then
        currentAnimation = pAnimation
        frame = animations[currentAnimation].first
    end
end

function updateAnimation(dt)
    frame = frame + 2 * dt
    if frame >= animations[currentAnimation].last + 1 then
        frame = animations[currentAnimation].first
    end
end

function player.load()
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player = createSprite("player_blue_armor_idle_with_gun", player.x, player.y)

    changeAnimation(animationsStatesIdle.forward)
end

function playerControls(dt)
    if love.keyboard.isDown("up") and player.y >= 0 + PLAYER_HEIGHT / 2 then
        player.y = player.y - 100 * dt
        changeAnimation(animationsStatesIdle.upwards)
    elseif love.keyboard.isDown("right") and player.x <= love.graphics.getWidth() - PLAYER_WIDTH / 2 then
        player.x = player.x + 100 * dt
        changeAnimation(animationsStatesIdle.forward)
    elseif love.keyboard.isDown("down") and player.y <= love.graphics.getHeight() - PLAYER_HEIGHT / 2 then
        player.y = player.y + 100 * dt
        changeAnimation(animationsStatesIdle.downward)
    elseif love.keyboard.isDown("left") and player.x >= 0 + PLAYER_WIDTH / 2 then
        player.x = player.x - 100 * dt
        changeAnimation(animationsStatesIdle.backwards)
    end
end

function player.update(dt)
    updateAnimation(dt)
    playerControls(dt)
end

function player.draw()
    local currentFrame = math.floor(frame)
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

    --love.graphics.circle("fill", player.x, player.y, 2)
    love.graphics.print(math.floor(frame))
end

return player
