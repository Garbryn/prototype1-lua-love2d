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

local listZonesSpawn = {}

local SpritesManager = require("SpritesManager")
local ShootManager = require("ShootManager")

IntervalSpawn = 5
local timerSpawn = IntervalSpawn

function init()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function CreateEnemy(pType, pX, pY)
    print("Create enemy " .. tostring(pType))
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
        enemy.speed = 50
    elseif pType == 2 then
        enemy.speed = 75
    elseif pType == 3 then
        enemy.speed = 25
    end

    table.insert(listEnemies, enemy)
end

function StartGame()
    ----------
    player = CreateSprites("player", screenWidth / 2, screenHeight / 2)
    player.speed = 200
    ----------

    ----------
end

function love.load()
    init()
    ----------
    print("Affichage des zones de spawn")
    ----------
    listZonesSpawn[1] = {
        x = screenWidth / 2,
        y = 16 + 5,
        angle = math.pi / 2
    }
    listZonesSpawn[2] = {
        x = (screenWidth - 16) - 5,
        y = screenHeight / 2,
        angle = math.pi
    }
    listZonesSpawn[3] = {
        x = screenWidth / 2,
        y = (screenHeight - 16) - 5,
        angle = math.pi * 1.5
    }
    listZonesSpawn[4] = {
        x = 16 + 5,
        y = screenHeight / 2,
        angle = 0
    }
    ----------
    print("Affichage des zones de spawn")
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
    timerSpawn = timerSpawn - dt
    local dice = math.random(1, #listZonesSpawn)
    local random_x = listZonesSpawn[dice].x
    local random_y = listZonesSpawn[dice].y

    local random_type = math.random(1, 3)
    if timerSpawn <= 0 then
        CreateEnemy(random_type, random_x, random_y)
        timerSpawn = IntervalSpawn
    end
    ----------
    -- ENEMIES --
    for n = #listEnemies, 1, -1 do
        local enemy = listEnemies[n]
        local shoot_x, shoot_y
        local speed_x, speed_y
        local angle = math.angle(enemy.x, enemy.y, player.x, player.y)

        enemy.timer = enemy.timer - dt

        if enemy.type == 1 then
            speed_x = (enemy.speed * dt) * math.cos(angle)
            speed_y = (enemy.speed * dt) * math.sin(angle)
            enemy.x = enemy.x + speed_x
            enemy.y = enemy.y + speed_y

            enemy.timerShoot = math.random(0.5, 1)
            if enemy.timer <= 0 then
                enemy.timer = enemy.timerShoot
                shoot_x = 150 * math.cos(angle)
                shoot_y = 150 * math.sin(angle)

                CreateShoot(listShoots, "enemy", enemy.x, enemy.y, shoot_x, shoot_y, angle)
            end
        elseif enemy.type == 2 then
            speed_x = (enemy.speed * dt) * math.cos(angle)
            speed_y = (enemy.speed * dt) * math.sin(angle)
            enemy.x = enemy.x + speed_x
            enemy.y = enemy.y + speed_y

            enemy.timerShoot = math.random(1, 1.5)
            if enemy.timer <= 0 then
                enemy.timer = enemy.timerShoot
                shoot_x = 200 * math.cos(angle)
                shoot_y = 200 * math.sin(angle)

                CreateShoot(listShoots, "enemy", enemy.x, enemy.y, shoot_x, shoot_y, angle)
            end
        elseif enemy.type == 3 then
            speed_x = (enemy.speed * dt) * math.cos(angle)
            speed_y = (enemy.speed * dt) * math.sin(angle)
            enemy.x = enemy.x + speed_x
            enemy.y = enemy.y + speed_y

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
    local z
    for z = 1, #listZonesSpawn do
        local zoneSpawn = listZonesSpawn[z]
        love.graphics.rectangle("fill", zoneSpawn.x - 16, zoneSpawn.y - 16, 32, 32)
    end
    ----------
    DrawSprites(listSprites)
    ----------
    -- TIMER SHOOT ENEMIES
    local n
    local y = 17
    for n = 1, #listEnemies do
        local enemy = listEnemies[n]
        love.graphics.print("Timer tir enemy " .. tostring(n) .. " : " .. math.floor(enemy.timer * 10) / 10, 1, y)
        y = y + 17
    end
    ----------
    -- TIMER SPAWN ENEMIES
    love.graphics.print("Spawn ennemy in : " .. math.ceil(timerSpawn) .. "s", 1, y + 17)
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
    -- print(key)
    ----------
end
