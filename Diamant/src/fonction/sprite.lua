function sprite_new(fichier,LX,LY)
    sprite = {}
    sprite.img=love.graphics.newImage(fichier)
    sprite.frame={}
    sprite.imgX=sprite.img:getWidth()
    sprite.imgY=sprite.img:getHeight()
    
    for y=0,(sprite.imgY/LY)-1 do
            for x=0,(sprite.imgX/LX)-1 do
                sprite.frame[x+(y*(sprite.imgX/LX))] = love.graphics.newQuad(x*LX,y*LY,LX,LY ,sprite.imgX, sprite.imgY)
            end
    end
    sprite.LX=LX
    sprite.LY=LY
    
    return sprite
    
end

function sprite_draw(x,y,sprite,frame)
    love.graphics.drawq(sprite.img,sprite.frame[frame],x,y)
end
