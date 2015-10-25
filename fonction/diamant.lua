function setvol(nb)
    musicVol=musicVol+nb
    music1:setVolume(musicVol)
    music2:setVolume(musicVol)
    music3:setVolume(musicVol)
end



function SetMapProp(map)
    point=0
    for i =0,15,1 do
        for j =0,11,1 do
            if map_gettile(map,i,j)==7 then
                X=i*64
                Y=j*64
                map_settile(map,i,j,2)
            end
            if map_gettile(map,i,j)==5 then
                point=point+1
            end
            
        end
    end
return X,Y,point
end

function loadlevel(monde,niveau)
    map=map_new("/textures/textures"..texturepack.."/monde"..monde.."/tileset.png","/map/monde"..monde.."/map"..niveau..".map",16,12,64,64)
    X,Y,scorefinal = SetMapProp(map)
    score=0
    direction=2
    pixel=0
    move=false
    if niveau==1 then
        love.audio.stop()
        if monde==1 then
            love.audio.play(music1)
        elseif monde==2 then
            love.audio.play(music2)
        elseif monde==3 then
            love.audio.play(music3)
        end
    end
return map,X,Y,scorefinal
end

