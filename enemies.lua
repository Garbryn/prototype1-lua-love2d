local enemies = {}
local listEnemies = {}

local SpritesManager = require("SpritesManager")
local ShootManager = require("ShootManager")

function CreateEnemy(pType, pX, pY)
    local eImage = ""
    if pType == 1 then
        eImage = "enemy_1"
    elseif pType == 2 then
        eImage = "enemy_2"
    elseif pType == 3 then
        eImage = "enemy_3"
    end

    local enemy = CreateSprites(eImage, pX, pY)

    table.insert(listEnemies, enemy)
end

function enemies.load()
    ----------
    CreateEnemy(1, 150, 200)
    ----------
    CreateEnemy(2, 200, 400)
    ----------
    CreateEnemy(3, 500, 50)
    ----------
end

return enemies
