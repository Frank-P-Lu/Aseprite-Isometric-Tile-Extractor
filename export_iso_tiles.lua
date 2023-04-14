local spr = app.activeSprite
if spr == nil then
  app.alert("There is no active sprite")
  return
end


local dlg = Dialog("Isometric Tiles")
dlg:number{ id="numRows", label="Rows:", text="4", decimals=0 }
dlg:number{ id="numCols", label="Columns:", text="4", decimals=0 }
dlg:button{ id="ok", text="OK" }
dlg:button{ id="cancel", text="Cancel" }
dlg:show()

local data = dlg.data
if data.cancel then
  return
end

local numRows = data.numRows
local numCols = data.numCols
local totalTiles = numRows * numCols

-- Set the dimensions of the tiles and the gap between them
local srcTileWidth = 14
local srcTileHeight = 8
local gap = 2

-- Calculate the dimensions of the new sprite
local newSpriteWidth = totalTiles * (srcTileWidth + gap) - gap
local newSpriteHeight = srcTileHeight

local srcImg = app.activeCel.image

-- Create a new sprite with the calculated dimensions
local newSpr = Sprite(newSpriteWidth, newSpriteHeight, ColorMode.RGB)
local newImage = Image(newSpriteWidth, newSpriteHeight, ColorMode.RGB)

function copy_isometric_area(img, x, y)
    local tile_width = srcTileWidth
    local tile_height = srcTileHeight

    local shape = {
        {0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0}
    }

    local new_image = Image(tile_width, tile_height, ColorMode.RGB)

    for j = 0, tile_height - 1 do
        for i = 0, tile_width - 1 do
            if shape[j+1][i+1] == 1 then
                local pixel = img:getPixel(x + i, y + j)
                local r = app.pixelColor.rgbaR(pixel)
                local g = app.pixelColor.rgbaG(pixel)
                local b = app.pixelColor.rgbaB(pixel)
                local a = app.pixelColor.rgbaA(pixel)

                local new_pixel = app.pixelColor.rgba(r, g, b, a)
                new_image:putPixel(i, j, new_pixel)
            end
        end
    end

    return new_image
end

-- Loop through the grid and copy each tile onto the new sprite
local tileCounter = 0
local halfTileHeight = srcTileHeight / 2
for row = 0, numRows - 1 do
  for col = 0, numCols - 1 do
    local startX = col * srcTileHeight + row * srcTileHeight
    local startY = col * (-halfTileHeight) + row * halfTileHeight + (numRows - 1) * halfTileHeight

    local tileImg = copy_isometric_area(spr.cels[1].image, startX, startY)
    -- print("Row: " .. (row + 1) .. ", Col: " .. (col + 1) .. " => (" .. startX .. ", " .. startY .. ")")
    -- Calculate the position in the new sprite for the current tile
    local newTileX = tileCounter * (srcTileWidth + gap)
    local newTileY = 0

    newImage:drawImage(tileImg, newTileX, newTileY)
    tileCounter = tileCounter + 1
  end
end

-- Create a new cel in the new sprite and set its image to the newImg
local newCel = newSpr:newCel(newSpr.layers[1], 1)
newCel.image = newImage
app.activeSprite = newSpr
