function printinfo(move)
    love.graphics.print("FPS: "..love.timer.getFPS(), 1030, 0)
    love.graphics.print("persoX: "..persoX,1030,10)
    love.graphics.print("persoY: "..persoY,1030,20)
    if move==false then
        id=scanID(gamemap,persoX,persoY,0)
        scan=scanID(gamemap,persoX,persoY,direction)
        scanplus=scanIDplus(gamemap,persoX,persoY,direction)
    end
    love.graphics.print("id: "..id,1030,30)
    love.graphics.print("score: "..score,1030,40)
    love.graphics.print("score final: "..scorefinal,1030,50)
end
function printinfosprite()
    if move==false then  
        love.graphics.draw( gamemap.tiles, gamemap.tile[scanID(gamemap,persoX,persoY,0)], 1056, 120)
        love.graphics.draw( gamemap.tiles, gamemap.tile[scanID(gamemap,persoX,persoY,direction)], 1056, 184)
        love.graphics.draw( gamemap.tiles, gamemap.tile[scanIDplus(gamemap,persoX,persoY,direction)], 1056, 248)
        love.graphics.print(scanID(gamemap,persoX,persoY,0),1030,152)
        love.graphics.print(scanID(gamemap,persoX,persoY,direction),1030,216)
        love.graphics.print(scanIDplus(gamemap,persoX,persoY,direction),1030,280)
    end
    sprite_draw(1056,60,perso,direction)
end