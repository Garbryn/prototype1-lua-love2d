local ShootManager = {}
local listShoots = {}

function CreateShoot(pType, pX, pY, pSX, pSY)
    local shoot = {}
    shoot.x = pX
    shoot.y = pY
    shoot.type = pType
    shoot.sx = pSX
    shoot.sy = pSY

    table.insert(listShoots, shoot)
end

function UpdateShoot(dt)
    local n
    for n = #listShoots, 1, -1 do
        local shoot = listShoots[n]
        shoot.x = shoot.x + shoot.sx * dt
        shoot.y = shoot.y + shoot.sy * dt
    end
end

function DrawShoot()
    local n
    for n = 1, #listShoots do
        s = listShoots[n]
        if s.type == "player" then
            love.graphics.setColor(0, 0, 1, 1)
            love.graphics.circle("fill", s.x, s.y, 2.5)
            love.graphics.setColor(1, 1, 1, 1)
        elseif s.type == "enemy" then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.circle("fill", s.x, s.y, 2.5)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end

    love.graphics.print("Tirs : " .. #listShoots, 10, 16)
end

return ShootManager
