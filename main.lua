require("init")

local player = require("player")

function love.load()
    ----------
    player.load()
    ----------
end

function love.update(dt)
    ----------
    player.animations(dt)
    player.move(dt)
    ----------
end

function love.draw()
    ----------
    player.draw()
    ----------
end

function love.keypressed(key)
end
