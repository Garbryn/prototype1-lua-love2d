local sprites = {}

function createSprite(pNameImage, pX, pY)
    local sprite = {}
    sprite.image = love.graphics.newImage("images/" .. pNameImage .. ".png")
    sprite.x = pX
    sprite.y = pY
    sprite.frame = 0

    sprite.listFrames = {}

    local l, c
    local id = 1
    for l = 1, 4 do
        for c = 1, 2 do
            sprite.listFrames[id] =
                love.graphics.newQuad(
                (c - 1) * 32,
                (l - 1) * 32,
                32,
                32,
                sprite.image:getWidth(),
                sprite.image:getHeight()
            )
            table.insert(sprite.listFrames, id)
            id = id + 1
            print(sprite.listFrames[id])
        end
    end

    return sprite
end

return sprites
