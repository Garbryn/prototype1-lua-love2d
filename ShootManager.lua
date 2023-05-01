local ShootManager = {}
local listShoots = {}

function CreateShoot(pX, pY, pSpeed, pAngle)
    local shoot = {}
    shoot.x = pX
    shoot.y = pY
    shoot.speed = pSpeed
    shoot.angle = pAngle

    table.insert(listShoots, shoot)
end

function UpdateShoot(dt)
    local n
    for n = #listShoots, 1, -1 do
        local shoot = listShoots[n]
        shoot.x = shoot.x + (shoot.speed * dt) * math.cos(shoot.angle)
        shoot.y = shoot.y + (shoot.speed * dt) * math.sin(shoot.angle)
    end
end

function DrawShoot()
    local n
    for n = 1, #listShoots do
        s = listShoots[n]
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.circle("fill", s.x, s.y, 2.5)
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.print("Tirs : " .. #listShoots, 10, 26)
end

return ShootManager
