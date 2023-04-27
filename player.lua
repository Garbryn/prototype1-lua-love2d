local player = {}
player.x = 0
player.y = 0
player.image = nil
player.frames = {}

PLAYER_IDLE_FORWARD = 1
PLAYER_IDLE_DOWNWARD = 2
PLAYER_IDLE_BACKWARDS = 3
PLAYER_IDLE_UPWARDS = 4

player.status = {}

player.status[PLAYER_IDLE_FORWARD] = {}
player.status[PLAYER_IDLE_FORWARD].frameStart = 3
player.status[PLAYER_IDLE_FORWARD].frameEnd = 4

player.status[PLAYER_IDLE_DOWNWARD] = {}
player.status[PLAYER_IDLE_DOWNWARD].frameStart = 1
player.status[PLAYER_IDLE_DOWNWARD].frameEnd = 2

player.status[PLAYER_IDLE_BACKWARDS] = {}
player.status[PLAYER_IDLE_BACKWARDS].frameStart = 7
player.status[PLAYER_IDLE_BACKWARDS].frameEnd = 8

player.status[PLAYER_IDLE_UPWARDS] = {}
player.status[PLAYER_IDLE_UPWARDS].frameStart = 5
player.status[PLAYER_IDLE_UPWARDS].frameEnd = 6

frame = 1

function player.load()
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.image = love.graphics.newImage("images/player_blue_armor_idle_with_gun.png")

    frame = 7

    player.frames[1] = love.graphics.newQuad(0, 0, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[2] = love.graphics.newQuad(32, 0, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[3] = love.graphics.newQuad(0, 32, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[4] = love.graphics.newQuad(32, 32, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[5] = love.graphics.newQuad(0, 64, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[6] = love.graphics.newQuad(32, 64, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[7] = love.graphics.newQuad(0, 96, 32, 32, player.image:getWidth(), player.image:getHeight())
    player.frames[8] = love.graphics.newQuad(32, 96, 32, 32, player.image:getWidth(), player.image:getHeight())
end

function player.animations(dt)
    frame = frame + 2 * dt
    if frame >= player.status[PLAYER_IDLE_BACKWARDS].frameEnd + 1 then
        frame = player.status[PLAYER_IDLE_BACKWARDS].frameStart
    end
end

function player.draw()
    love.graphics.draw(player.image, player.frames[math.floor(frame)], player.x, player.y)
    love.graphics.print(math.floor(frame))
end

return player
