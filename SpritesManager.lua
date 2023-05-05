local SpriteManager = {}

local listSprites = {}

function CreateSprites(pImage, pX, pY)
    local sprite = {}

    sprite.image = love.graphics.newImage("assets/images/" .. pImage .. ".png")
    sprite.x = pX
    sprite.y = pY
    sprite.angle = 0

    sprite.width = sprite.image:getWidth()
    sprite.height = sprite.image:getHeight()

    sprite.ox = sprite.width / 2
    sprite.oy = sprite.height / 2

    sprite.delete = false

    table.insert(listSprites, sprite)

    return sprite
end

function PurgeSprites(dt)
    local n
    for n = #listSprites, 1, -1 do
        local sprite = listSprites[n]
        if sprite.delete == true then
            table.remove(listSprites, n)
        end
    end
end

function DrawSprites()
    ----------
    local n
    for n = 1, #listSprites do
        local sprite = listSprites[n]
        love.graphics.draw(sprite.image, sprite.x, sprite.y, 0, 1, 1, sprite.ox, sprite.oy)

        -- love.graphics.setColor(1, 0, 0, 1)
        -- love.graphics.circle("fill", sprite.x, sprite.y, 2)
        -- love.graphics.rectangle(
        --     "line",
        --     sprite.x - sprite.width / 2,
        --     sprite.y - sprite.height / 2,
        --     sprite.width,
        --     sprite.height
        -- )

        -- love.graphics.setColor(1, 1, 1, 1)
    end
    ----------
    love.graphics.print("Sprites : " .. #listSprites, 1, 1)
end

return SpriteManager
