function love.load()

    red = 115/255
    green = 27/255
    blue = 135/255
    alpha = 50/100
    love.graphics.setBackgroundColor( red, green, blue, alpha )
    success = love.window.setMode( 1200, 800 )

    scale = 0.5
    elemoffsety = math.floor( 320 * scale )
    elemoffsetx = math.floor( 160 * scale )
    offsetcol = math.floor( 182 * scale )
    offsetrow = math.floor( 79 * scale )
    offsetcoleven = math.floor( 91 * scale )

    Map1 = {
       [1] = {5,5,5,5,5,5,5,5,5,5},
       [2] = {1,2,2,2,3,5,5,5,5,5},
       [3] = {5,5,5,5,5,5,5,5,5,5},
       [4] = {5,5,5,5,5,5,5,5,5,5},
       [5] = {5,5,5,5,5,5,5,6,5,5},
       [6] = {5,5,5,5,5,5,5,5,5,5},
       [7] = {5,5,5,5,4,5,5,5,5,5},
       [8] = {5,5,5,5,5,5,5,5,5,5},
       [9] = {5,5,6,5,5,5,5,5,5,5},
       [10] = {5,5,5,5,5,5,5,5,6,5},   
    }

    EnumMapElem = {
        [1] = "RIVERBEG",
        [2] = "RIVERSTR",
        [3] = "RIVEREND",
        [4] = "WATHER",
        [5] = "GREENLAND",
        [6] = "ROCKS",
    }

    mouse = {}
end
-- ENUM function
function enum(tbl)
    local length = #tbl
    for i = 1, length do
        local v = tbl[i]
        tbl[v] = i
    end

    return tbl
end
-- update world with dt
function love.update( dt )
    mouse.x, mouse.y = love.mouse.getPosition()  -- This gets the x and y coordinates of the mouse and assigns those to these respectively.
end

-- load texture from enum
function giveTexture(row, col)
    local enum = Map1[row][col]
    if enum == 1 --EnumMapElem.RIVERBEG 
    then
        return "assets/river_start_N.png"
    end
    if enum == 2 --EnumMapElem.RIVERSTR 
    then
        return "assets/river_straight_N.png"
    end
    if enum == 3 --EnumMapElem.RIVEREND 
    then
        return "assets/river_end_N.png"
    end
    if enum == 4 --EnumMapElem.WATHER 
    then
        return "assets/water_N.png"
    end
    if enum == 5 --EnumMapElem.GREENLAND 
    then
        return "assets/grass_N.png"
    end
    if enum == 6 --EnumMapElem.ROCKS 
    then
        return "assets/stone_rocks_N.png"
    end

end

function love.draw()
    local col = 0
    local row = 0
       
    love.graphics.print("Mouse Coordinates: " .. mouse.x .. ", " .. mouse.y)

    for i = 1, 10 , 1 do
        row = offsetrow * i
        for y = 1, 10 , 1 do
            if i % 2 == 0 then
                col = offsetcol * y
            else
                col = offsetcoleven + offsetcol * y
            end

            if ((mouse.y >= row + elemoffsety) and (mouse.y <= row + elemoffsety + offsetrow) and (mouse.x >= col + elemoffsetx) and (mouse.x <= col + elemoffsetx + offsetcol)) then
                love.graphics.draw( love.graphics.newImage( giveTexture( i,y ) ), col, row+15, 0, scale )
            else
                love.graphics.draw( love.graphics.newImage( giveTexture( i,y ) ), col, row, 0, scale )
            end
            col = 0
        end    
    end

end