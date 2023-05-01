--[[
      ___           ___           ___           ___                                  ___           ___                    ___                   
     /  /\         /  /\         /  /\         /  /\          ___                   /  /\         /  /\                  /  /\          ___     
    /  /::\       /  /:/        /  /::\       /  /::\        /__/\                 /  /::\       /  /::|                /  /:/         /  /\    
   /__/:/\:\     /  /:/        /  /:/\:\     /  /:/\:\       \  \:\               /  /:/\:\     /  /:|:|               /  /:/         /  /::\   
  _\_ \:\ \:\   /  /::\ ___   /  /:/  \:\   /  /:/  \:\       \__\:\             /  /::\ \:\   /  /:/|:|__            /  /:/         /  /:/\:\  
 /__/\ \:\ \:\ /__/:/\:\  /\ /__/:/ \__\:\ /__/:/ \__\:\      /  /::\           /__/:/\:\ \:\ /__/:/_|::::\          /__/:/     /\  /  /::\ \:\ 
 \  \:\ \:\_\/ \__\/  \:\/:/ \  \:\ /  /:/ \  \:\ /  /:/     /  /:/\:\          \  \:\ \:\_\/ \__\/  /~~/:/          \  \:\    /:/ /__/:/\:\_\:\
  \  \:\_\:\        \__\::/   \  \:\  /:/   \  \:\  /:/     /  /:/__\/           \  \:\ \:\         /  /:/            \  \:\  /:/  \__\/  \:\/:/
   \  \:\/:/        /  /:/     \  \:\/:/     \  \:\/:/     /__/:/                 \  \:\_\/        /  /:/              \  \:\/:/        \  \::/ 
    \  \::/        /__/:/       \  \::/       \  \::/      \__\/                   \  \:\         /__/:/                \  \::/          \__\/  
     \__\/         \__\/         \__\/         \__\/                                \__\/         \__\/                  \__\/                  

    by Garbryn
    ]] --

-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- Désactive le lissage en cas de scale
love.graphics.setDefaultFilter("nearest")

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

local player = require("player")
local enemies = require("enemies")

function love.load()
    ----------
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    ----------
    print("Chargement des entités...")
    ----------
    player.load()
    ----------
    enemies.load()
    ----------
    print("Fin de chargement des entités.")
end

function love.update(dt)
    ----------
    PlayerController(dt)
    ----------
    UpdateShoot(dt)
    ----------
end

function love.draw()
    ----------
    DrawShoot()
    ----------
    DrawSprites()
    ----------
end

function love.keypressed(key)
    ----------
    print(key)
    ----------
end
