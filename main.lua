require("init")

local player = require("player")
local enemies = require("enemies")

function love.load()
    ----------
    player.load()
    ----------
end

function love.update(dt)
    ----------
    player.update(dt)
    ----------
end

function love.draw()
    ----------
    player.draw()
    ----------
end

function love.keypressed(key)
end
