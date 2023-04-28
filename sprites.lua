local sprites = {}

IDLE_FORWARD = 1
IDLE_DOWNWARD = 2
IDLE_BACKWARDS = 3
IDLE_UPWARDS = 4

function createSprite(pNameImage, pStatus, pFrameStart, pFrameEnd)
    local sprite = {}
    sprite.image = love.graphics.newImage("images/" .. pNameImage .. ".png")
    sprite.frames = {}

    local l, c
    id = 1
    for l = 1, 4 do
        for c = 1, 2 do
            sprite.frames[id] =
                love.graphics.newQuad(
                (c - 1) * 32,
                (l - 1) * 32,
                32,
                32,
                sprite.image:getWidth(),
                sprite.image:getHeight()
            )
            id = id + 1
        end
    end

    frame = pFrameStart

    sprite.status = {}

    sprite.status[pStatus] = {}
    sprite.status[pStatus].frameStart = pFrameStart
    sprite.status[pStatus].frameEnd = pFrameEnd

    sprite.status[pStatus] = {}
    sprite.status[pStatus].frameStart = pFrameStart
    sprite.status[pStatus].frameEnd = pFrameEnd

    sprite.status[pStatus] = {}
    sprite.status[pStatus].frameStart = pFrameStart
    sprite.status[pStatus].frameEnd = pFrameEnd

    sprite.status[pStatus] = {}
    sprite.status[pStatus].frameStart = pFrameStart
    sprite.status[pStatus].frameEnd = pFrameEnd

    return sprite
end

return sprites
