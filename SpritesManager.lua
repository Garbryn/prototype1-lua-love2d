local SpriteManager = {}
local listSprites = {}

function CreateSprites(pImage, pX, pY, pSpeed)
    local sprite = {}
    sprite.image = love.graphics.newImage("assets/images/" .. pImage .. ".png")
    sprite.x = pX
    sprite.y = pY
    sprite.width = sprite.image:getWidth()
    sprite.height = sprite.image:getHeight()
    sprite.ox = sprite.width / 2
    sprite.oy = sprite.height / 2
    sprite.speed = pSpeed

    table.insert(listSprites, sprite)

    return sprite
end

function DrawSprites()
    ----------
    local n
    for n = 1, #listSprites do
        local s = listSprites[n]
        love.graphics.draw(s.image, s.x, s.y, 0, 1, 1, s.ox, s.oy)

        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.circle("fill", s.x, s.y, 2)
        love.graphics.rectangle("line", s.x - s.width / 2, s.y - s.height / 2, s.width, s.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
    ----------
    love.graphics.print("Sprites : " .. #listSprites, 10, 10)
end

return SpriteManager
