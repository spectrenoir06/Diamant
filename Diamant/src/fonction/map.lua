function map_read(fichier)
f = love.filesystem.read(fichier)
map = {}

for line in love.filesystem.lines(fichier) do

    map_line = {}
    pos=1
    dep,fin = string.find(line, "|")
    while dep ~= nil do
        table.insert(map_line, tonumber(string.sub(line, pos, dep-1)))
        pos=fin+1
        dep,fin = string.find(line, "|", pos)
    end
    table.insert(map_line, tonumber(string.sub(line, pos, -1)))
    table.insert( map, map_line )
end
return map
end

function map_new(tiles,fichier,X,Y,LX,LY) --créer une map

maptable=map_read(fichier)
   
    map={}
    map["file"]=fichier
    map["map"]=maptable
    map["X"]=X
    map["Y"]=Y
    map["LX"]=LX
    map["LY"]=LY
    map["tiles"]=love.graphics.newImage(tiles)
    map["tilesetX"]=map.tiles:getWidth()
    map["tilesetY"]=map.tiles:getHeight()
    tile={}
    for y=0,(map.tilesetY/LY)-1 do
        for x=0,(map.tilesetX/LX)-1 do
            tile[x+(y*map.tilesetX/LX)] = love.graphics.newQuad(x*map.LX,y*map.LY, map.LX, map.LY ,map.tilesetX, map.tilesetY)
        end
    end
    map["tile"]=tile
    map["spriteBatch"] = love.graphics.newSpriteBatch( map.tiles, map.X*map.Y )
    map_update(map) 
    return map    
end

function map_update(map) 
    map.spriteBatch:clear()
    for x=0,(map.X)-1 do
        for y=0,(map.Y)-1 do
            id = map.map[y+1][x+1]
            map.spriteBatch:add(map.tile[id], x*map.LX, y*map.LY)
        end
    end

end
function map_draw(x,y,map)
    love.graphics.draw(map.spriteBatch,x,y)
end

function map_gettile(map,x,y)

    return map.map[y+1][x+1]

end

function map_settile(map,x,y,id)
    map.map[y+1][x+1]=id
    map_update(map)

end

function map_reset(map)
    map.map=nil
    map.map=map_read(map.file)
    map_update(map) 
    score=0
return
end