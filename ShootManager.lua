local ShootManager = {}

function CreateShoot(pList, pType, pX, pY, pSpeed_x, pSpeed_y, pAngle)
    local nameImage

    if pType == "player" then
        nameImage = "Fire_Bullet_1"
    elseif pType == "enemy" then
        nameImage = "Fire_Bullet_2"
    end
    local shoot = CreateSprites(nameImage, pX, pY)

    shoot.type = pType
    shoot.timer = 0

    shoot.speed_x = pSpeed_x
    shoot.speed_y = pSpeed_y
    shoot.angle = pAngle

    table.insert(pList, shoot)
end

function UpdateShoot(pList, pLimit_x, pLimit_y, dt)
    local n
    for n = #pList, 1, -1 do
        local shoot = pList[n]
        shoot.x = shoot.x + shoot.speed_x * dt
        shoot.y = shoot.y + shoot.speed_y * dt
        if shoot.x >= pLimit_x or shoot.x <= 0 or shoot.y >= pLimit_y or shoot.y <= 0 then
            shoot.delete = true
            table.remove(pList, n)
        end
    end
end

return ShootManager
