-- -- -- -- -- -- -- 
-- ENUM DEFINES
TailName = {
    GREENLAND = 1,
    RIVERBEG = 2,
    RIVERSTR = 3,
    RIVEREND = 4,
    WATHER = 5,
    ROCKS = 6,
}

EnemyMov = {
    NOWALK = 0,
    FULLSPEEDWALK = 1,
    HALFSPEEDWALK = 2,
}
-- -- -- -- -- -- -- 

-- -- -- -- -- -- -- 
-- MAP OBJECT PROPERTIES for each type of map object are stored here in columns ([object type] = {prperty1, property2}) in the order: 
-- texture name and location
-- enemy can walk through [0-no; 1-yes, 2-slowed down],
-- object can be build on it [ 0-no, 1-yes,]
-- map object can be cleared from osbstacles [0-no, 1-yes]
-- type of object that this obcject can be changed to [0-default, object number]
objProperties = {
    [1] = {asset= "assets/grass_N.png", walk= EnemyMov.FULLSPEEDWALK, build= true, clear= false, typec= 0},
    [2] = {asset= "assets/river_start_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [3] = {asset= "assets/river_straight_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [4] = {asset= "assets/river_end_S.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [5] = {asset= "assets/water_N.png",walk= EnemyMov.NOWALK, build= false, clear= true, typec= 0},
    [6] = {asset= "assets/stone_rocks_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 1},

    -- [7] = {1,1,1,1,1},
    -- [8] = {1,1,1,1,1},
    -- [9] = {1,1,1,1,1},
    -- [10] = {1,1,1,1,1}, 
}
-- -- -- -- -- -- -- 

function love.load()

    red = 40/255
    green = 160/255
    blue = 255/255
    alpha = 0/100
    love.graphics.setBackgroundColor( red, green, blue, alpha )
    success = love.window.setMode( 1200, 800 )

    scale = 0.5
    elemoffsety = math.floor( 320 * scale )
    elemoffsetx = math.floor( 160 * scale )
    offsetcol = math.floor( 182 * scale )
    offsetrow = math.floor( 79 * scale )
    offsetcoleven = math.floor( 91 * scale )

    Map1 = {
       [1] = {1,1,1,1,1,1,1,1,1,1},
       [2] = {1,2,3,3,4,1,1,1,1,1},
       [3] = {1,1,1,1,1,1,1,1,1,1},
       [4] = {1,1,1,1,1,1,1,1,1,1},
       [5] = {1,1,1,1,6,1,1,1,6,1},
       [6] = {1,1,1,1,1,1,1,1,1,1},
       [7] = {1,1,1,1,5,1,1,1,1,1},
       [8] = {1,1,1,1,1,1,1,1,1,1},
       [9] = {1,1,5,1,1,1,1,1,1,1},
       [10] = {1,1,1,1,1,1,1,1,6,1},   
    }


    mouse = {}

    -- -- -- -- -- -- --
    -- CREATE DRAWABLE OBJECT for current map
    image = {}

    for i = 1, 10 , 1 do
        for y = 1, 10 , 1 do    
            local type  = lookuptable( i,y )
            if image[type] == nil then
                image[type] = love.graphics.newImage( giveTexture( type ))
            end
        end    
    end
    -- -- -- -- -- -- --
end



-- update world with dt
function love.update( dt )
end

-- lookuptable - helping function
function lookuptable( row, col )
    local type = Map1[row][col]
    return type
end

-- load texture from enum
function giveTexture( type )
    return objProperties[type].asset 
end


function moveTroughField( type )
    if type == TailName.GREENLAND then
        return true
    else
        return false
    end
end

function love.draw()
    local col = 0
    local row = 0
    mouse.x, mouse.y = love.mouse.getPosition()
       
    love.graphics.print("Mouse Coordinates: " .. mouse.x .. ", " .. mouse.y)


    -- -- -- -- -- -- --
    -- DRAWABLE OBJECT for current map
    for i = 1, 10 , 1 do
        row = offsetrow * i
        for y = 1, 10 , 1 do
            if i % 2 == 0 then
                col = offsetcol * y
            else
                col = offsetcoleven + offsetcol * y
            end

            if ((moveTroughField(lookuptable(i,y)) and mouse.y >= row + elemoffsety ) and ( mouse.y <= row + elemoffsety + offsetrow ) and ( mouse.x >= col + elemoffsetx ) and ( mouse.x <= col + elemoffsetx + offsetcol )) then
                love.graphics.draw( image[lookuptable( i, y )], col, row+15, 0, scale )
            else
                love.graphics.draw( image[lookuptable( i, y )], col, row, 0, scale )
            end
            col = 0
        end    
    end
    -- -- -- -- -- -- --

end