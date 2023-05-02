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

local player = {}

local listEnemies = {}

local SpritesManager = require("SpritesManager")
local ShootManager = require("ShootManager")

local timer = 0

function init()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function CreateEnemy(pType, pX, pY)
    local nameImage
    if pType == 1 then
        nameImage = "enemy_1"
    elseif pType == 2 then
        nameImage = "enemy_2"
    elseif pType == 3 then
        nameImage = "enemy_3"
    end

    local enemy = CreateSprites(nameImage, pX, pY)
    enemy.type = pType
    enemy.timerShoot = 0
    enemy.angle = 0

    table.insert(listEnemies, enemy)
end

function StartGame()
    ----------
    player = CreateSprites("player", screenWidth / 2, screenHeight / 2, 100)
    ----------
    CreateEnemy(1, 150, 200)
    ----------
    CreateEnemy(2, 200, 400)
    ----------
    CreateEnemy(3, 500, 50)
    ----------
end

function love.load()
    init()
    ----------
    print("Chargement des entités...")
    ----------
    StartGame()
    ----------
    print("Fin de chargement des entités.")
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

function love.update(dt)
    ----------
    UpdateShoot(dt)
    ----------
    local n
    for n = #listEnemies, 1, -1 do
        local enemy = listEnemies[n]
        timer = timer - dt
        if enemy.type == 1 then
            if timer <= 0 then
                timer = math.random(1, 2)
                local sx, sy
                local angle
                angle = math.angle(enemy.x, enemy.y, player.x, player.y)
                sx = 150 * math.cos(angle)
                sy = 150 * math.sin(angle)
                CreateShoot("enemy", enemy.x, enemy.y, sx, sy)
            end
        elseif enemy.type == 2 then
            if timer <= 0 then
                timer = math.random(3, 5)
                local sx, sy
                local angle
                angle = math.angle(enemy.x, enemy.y, player.x, player.y)
                sx = 200 * math.cos(angle)
                sy = 200 * math.sin(angle)
                CreateShoot("enemy", enemy.x, enemy.y, sx, sy)
            end
        elseif enemy.type == 3 then
            if timer <= 0 then
                timer = math.random(2, 4)
                local sx, sy
                local angle
                angle = math.angle(enemy.x, enemy.y, player.x, player.y)
                sx = 75 * math.cos(angle)
                sy = 75 * math.sin(angle)
                CreateShoot("enemy", enemy.x, enemy.y, sx, sy)
            end
        end
    end
    ----------
    PlayerController(dt)
    ----------
end

function love.draw()
    ----------
    DrawShoot()
    ----------
    DrawSprites()
    ----------
    love.graphics.print("Prochain tir : " .. math.floor(timer), 10, 32)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local sx, sy
        local angle = math.angle(player.x, player.y, x, y)
        sx = 250 * math.cos(angle)
        sy = 250 * math.sin(angle)
        CreateShoot("player", player.x, player.y, sx, sy)
    end
end

function love.keypressed(key)
    ----------
    print(key)
    ----------
end
