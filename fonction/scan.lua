function scanIDplus(map,X,Y,direction)
    if direction == 1 then
        id=map_gettile(map,X/64,(Y/64)-2)
    elseif direction == 2 then
        id=map_gettile(map,X/64,(Y/64)+2)
    elseif direction == 3 then
        id=map_gettile(map,(X/64)-2,Y/64)
    elseif direction == 4 then
        id=map_gettile(map,(X/64)+2,Y/64)
    end
    return id
end
function scanID(map,X,Y,direction)
    if direction == 0 then
        id=map_gettile(map,X/64,Y/64)
    elseif direction == 1 then
        id=map_gettile(map,X/64,(Y/64)-1)
    elseif direction == 2 then
        id=map_gettile(map,X/64,(Y/64)+1)
    elseif direction == 3 then
        id=map_gettile(map,(X/64)-1,Y/64)
    elseif direction == 4 then
        id=map_gettile(map,(X/64)+1,Y/64)
    end
    return id
end

function scanCol(map,X,Y,direction,wall)
    colision=wall[scanID(map,X,Y,direction)]
    return colision
end

function pousser(map,X,Y,direction,Score)
    if scanID(map,X,Y,direction)==3 and scanIDplus(map,X,Y,direction)==2 then--diamant->dalle
        if direction == 1 then
            map_settile(map,X/64,Y/64-1,2)
            map_settile(map,X/64,Y/64-2,3)
        end
        if direction == 2 then
            map_settile(map,X/64,Y/64+1,2)
            map_settile(map,X/64,Y/64+2,3)
        end
        if direction == 3 then
            map_settile(map,X/64-1,Y/64,2)
            map_settile(map,X/64-2,Y/64,3)
        end
        if direction == 4 then
            map_settile(map,X/64+1,Y/64,2)
            map_settile(map,X/64+2,Y/64,3)
        end
    end
    if scanID(map,X,Y,direction)==3 and scanIDplus(map,X,Y,direction)==5 then --diamant->socle       
        if direction == 1 then
            map_settile(map,X/64,Y/64-1,2)
            map_settile(map,X/64,Y/64-2,4)
        end
        if direction == 2 then
            map_settile(map,X/64,Y/64+1,2)
            map_settile(map,X/64,Y/64+2,4)
        end
        if direction == 3 then
            map_settile(map,X/64-1,Y/64,2)
            map_settile(map,X/64-2,Y/64,4)
        end
        if direction == 4 then
            map_settile(map,X/64+1,Y/64,2)
            map_settile(map,X/64+2,Y/64,4)
        end
        love.audio.rewind(son1)
        love.audio.play(son1)
        score=score+1        
    end
    
    if scanID(map,X,Y,direction)==4 and scanIDplus(map,X,Y,direction)==2 then  --enlever diamant socle
        if direction == 1 then
            map_settile(map,X/64,Y/64-1,5)
            map_settile(map,X/64,Y/64-2,3)
        end
        if direction == 2 then
            map_settile(map,X/64,Y/64+1,5)
            map_settile(map,X/64,Y/64+2,3)
        end
        if direction == 3 then
            map_settile(map,X/64-1,Y/64,5)
            map_settile(map,X/64-2,Y/64,3)
        end
        if direction == 4 then
            map_settile(map,X/64+1,Y/64,5)
            map_settile(map,X/64+2,Y/64,3)
        end
        score=score-1
    end
    
    if scanID(map,X,Y,direction)==4 and scanIDplus(map,X,Y,direction)==5 then  --diamant rouge --> socle
        if direction == 1 then
            map_settile(map,X/64,Y/64-1,5)
            map_settile(map,X/64,Y/64-2,4)
        end
        if direction == 2 then
            map_settile(map,X/64,Y/64+1,5)
            map_settile(map,X/64,Y/64+2,4)
        end
        if direction == 3 then
            map_settile(map,X/64-1,Y/64,5)
            map_settile(map,X/64-2,Y/64,4)
        end
        if direction == 4 then
            map_settile(map,X/64+1,Y/64,5)
            map_settile(map,X/64+2,Y/64,4)
        end
        love.audio.rewind(son2)
        love.audio.play(son2)
    end  
    
    return score
end