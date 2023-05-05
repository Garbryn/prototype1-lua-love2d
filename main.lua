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

    by Garbryn - 2023
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

function collide(a1, a2)
    if (a1 == a2) then
        return false
    end
    local dx = a1.x - a2.x
    local dy = a1.y - a2.y
    if (math.abs(dx) < a1.image:getWidth() / 2 + a2.image:getWidth() / 2) then
        if (math.abs(dy) < a1.image:getHeight() / 2 + a2.image:getHeight() / 2) then
            return true
        end
    end
    return false
end

local player = {}
player.speed = 0

local listEnemies = {}
local listShoots = {}

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
    enemy.timer = enemy.timerShoot
    enemy.angle = 0
    enemy.speed = 0

    if pType == 1 then
        enemy.speed = 100
    elseif pType == 2 then
        enemy.speed = 150
    elseif pType == 3 then
        enemy.speed = 200
    end

    table.insert(listEnemies, enemy)
end

function StartGame()
    ----------
    player = CreateSprites("player", screenWidth / 2, screenHeight / 2)
    player.speed = 200
    ----------
    CreateEnemy(1, 150, 200)
    CreateEnemy(2, 200, 400)
    CreateEnemy(3, 500, 50)
    ----------
    timer = 2
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
    UpdateShoot(listShoots, screenWidth, screenHeight, dt)
    ----------
    local n
    ----------
    -- SHOOTS --
    for n = #listShoots, 1, -1 do
        local shoot = listShoots[n]
        if shoot.type == "player" then
            local nEnemy
            for nEnemy = #listEnemies, 1, -1 do
                local enemy = listEnemies[nEnemy]
                if collide(shoot, enemy) then
                    shoot.delete = true
                    table.remove(listShoots, n)
                end
                if enemy.type == 1 and collide(enemy, shoot) then
                    enemy.delete = true
                    table.remove(listEnemies, nEnemy)
                end
            end
        end
        if shoot.type == "enemy" then
            if collide(shoot, player) then
                shoot.delete = true
                table.remove(listShoots, n)
            end
        end
    end
    ----------
    -- ENEMIES --
    for n = #listEnemies, 1, -1 do
        local enemy = listEnemies[n]
        local shoot_x, shoot_y
        local angle = math.angle(enemy.x, enemy.y, player.x, player.y)
        enemy.timer = enemy.timer - dt

        if enemy.type == 1 then
            enemy.timerShoot = math.random(0.5, 1)
            if enemy.timer <= 0 then
                enemy.timer = enemy.timerShoot
                shoot_x = 150 * math.cos(angle)
                shoot_y = 150 * math.sin(angle)

                CreateShoot(listShoots, "enemy", enemy.x, enemy.y, shoot_x, shoot_y, angle)
            end
        elseif enemy.type == 2 then
            enemy.timerShoot = math.random(1, 1.5)
            if enemy.timer <= 0 then
                enemy.timer = enemy.timerShoot
                shoot_x = 200 * math.cos(angle)
                shoot_y = 200 * math.sin(angle)

                CreateShoot(listShoots, "enemy", enemy.x, enemy.y, shoot_x, shoot_y, angle)
            end
        elseif enemy.type == 3 then
            enemy.timerShoot = math.random(1.5, 2)
            if enemy.timer <= 0 then
                enemy.timer = enemy.timerShoot
                shoot_x = 150 * math.cos(angle)
                shoot_y = 150 * math.sin(angle)

                CreateShoot(listShoots, "enemy", enemy.x, enemy.y, shoot_x, shoot_y, angle)
            end
        end
    end
    ----------
    PurgeSprites(dt)
    ----------
    PlayerController(dt)
    ----------
end

function love.draw()
    ----------
    DrawSprites(listSprites)
    ----------
    local n
    local y = 17
    for n = 1, #listEnemies do
        local enemy = listEnemies[n]
        love.graphics.print("Timer tir enemy " .. tostring(n) .. " : " .. math.floor(enemy.timer * 10) / 10, 1, y)
        y = y + 17
    end
    ----------
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local shoot_x, shoot_y
        local angle = math.angle(player.x, player.y, x, y)
        shoot_x = 200 * math.cos(angle)
        shoot_y = 200 * math.sin(angle)
        CreateShoot(listShoots, "player", player.x, player.y, shoot_x, shoot_y, player.angle)
    end
end

function love.keypressed(key)
    ----------
    print(key)
    ----------
end
