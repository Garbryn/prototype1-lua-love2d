local player = {}
player.x = 0
player.y = 0
player.image = nil
player.frames = {}
frame = 1

function player.load()
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.image = love.graphics.newImage("images/player_blue_armor_idle_with_gun.png")

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
    frame = frame + dt
    if frame >= #player.frames + 1 then
        frame = 1
    end
end

function player.draw()
    love.graphics.draw(player.image, player.frames[math.floor(frame)], player.x, player.y)
    love.graphics.print(math.floor(frame))
end

return player
