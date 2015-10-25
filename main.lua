require "/fonction/map"
require "/fonction/diamant"
require "/fonction/scan"
require "/fonction/sprite"
require "/fonction/Button"
require "/fonction/info"



--[[function save.new()

save={}
save.niveau1=true
save.niveau2=false
save.niveau3=false

save.score1=99999999
save.score2=99999999
save.score3=99999999

return save
end

function save(fichier)





end
--]]

function love.load()

	monde1=love.graphics.newImage( "/textures/textures1/Menu/menu_monde1.png" )
	monde2=love.graphics.newImage( "/textures/textures1/Menu/menu_monde2.png" )
	monde3=love.graphics.newImage( "/textures/textures1/Menu/menu_monde3.png" )

	mode="start"
	stime = love.timer.getTime()
	menuscreen = love.graphics.newImage( "/textures/textures1/Menu/ecran.png" )
	icone=( love.graphics.newImage( "icone.png" ) )
	music1 = love.audio.newSource("/music/music1.mp3")
	music2 = love.audio.newSource("/music/music2.mp3")
	music3 = love.audio.newSource("/music/music3.mp3")
	musicVol=1
	music1:setVolume(musicVol)
	music2:setVolume(musicVol)
	music3:setVolume(musicVol)
	son1 = love.audio.newSource("/music/son1.wav", "static")
	son2 = love.audio.newSource("/music/son2.wav", "static")
	texturepack=1
	niveau=1
	perso=sprite_new("/textures/Perso1/sprite.png",64,80)
	info=false
	wall = {}
	wall[2] = true  -- Dalles
	wall[1] = true --herbe
	wall[3] = false  --Diamant
	wall[4] = false --Diamant rouge
	wall[5] = true -- socle diamant
	wall[6] = false --Caisse
	wall[7] = true -- Spawn
	wall[8] = false -- Mur
	wall[9] = false --sol rugeu

	joysticks = love.joystick.getJoysticks( )
	joy = joysticks[1]

end


-----------



function love.draw()

	if mode=="play" then
		map_draw(128,0,gamemap)
		sprite_draw(persoX + 128,persoY-6*4,perso,direction)
		if info==true then
			printinfo()
			printinfosprite(map,X,Y,direction)
		end

	elseif mode=="start" then
		love.graphics.draw( menuscreen, 0, 0)
		button_draw(10 + 128 - 42,245,monde1)
		button_draw(350 + 128,245,monde2)
		button_draw(700 + 128 + 42,245,monde3)
		if cursor then
			love.graphics.print( cursorX.." ; "..cursorY, cursorX, cursorY)
		end
	end
end

function love.update(dt)
	if mode=="play" then
		if move==false then
			if (love.keyboard.isDown( " " ) or (joy and joy:isDown(1))) then
				score=pousser(gamemap,persoX,persoY,direction,score)
			elseif (love.keyboard.isDown( "up" ) or (joy and joy:isDown(12))) and direction==1 and scanCol(gamemap,persoX,persoY,direction,wall) then
				pixel=0
				move=true
			elseif (love.keyboard.isDown( "down" ) or (joy and joy:isDown(13))) and direction==2 and scanCol(gamemap,persoX,persoY,direction,wall) then
				pixel=0
				move=true
			elseif (love.keyboard.isDown( "left" ) or (joy and joy:isDown(14))) and direction==3 and scanCol(gamemap,persoX,persoY,direction,wall)  then
				pixel=0
				move=true
			elseif (love.keyboard.isDown( "right" ) or (joy and joy:isDown(15))) and direction==4 and scanCol(gamemap,persoX,persoY,direction,wall)  then
				pixel=0
				move=true
			elseif (love.keyboard.isDown( "up" ) or (joy and joy:isDown(12))) then
				direction=1
			elseif (love.keyboard.isDown( "down" ) or (joy and joy:isDown(13))) then
				direction=2
			elseif (love.keyboard.isDown( "left" ) or (joy and joy:isDown(14))) then
				direction=3
			elseif (love.keyboard.isDown( "right" ) or (joy and joy:isDown(15))) then
				direction=4
			elseif (love.keyboard.isDown( "escape" ) or (joy and joy:isDown(4))) then
				map_reset(gamemap)
				persoX,persoY=SetMapProp(gamemap)
			elseif score==scorefinal  then
				niveau=niveau+1
				if niveau == 11 then
					mode="start"
				else
					gamemap,persoX,persoY,scorefinal=loadlevel(monde,niveau)
				end
			end
		else
			if direction==1 then
				persoY=persoY-8
				pixel=pixel+8
			elseif direction==2 then
				persoY=persoY+8
				pixel=pixel+8
			elseif direction==3 then
				persoX=persoX-8
				pixel=pixel+8
			elseif direction==4 then
				persoX=persoX+8
				pixel=pixel+8
			end
			if pixel==64 then
				move = false
			end
		end

	elseif mode=="start" then
		love.audio.stop()


	elseif mode=="launchgame" then
		gamemap,persoX,persoY,scorefinal=loadlevel(monde,niveau)
		mode="play"
	end


end


function love.mousepressed(x, y, button)

	if mode=="start" then
		if button_press(10 + 128 - 42, 245, monde1,x,y,button) then
			niveau=1
			monde=1
			mode="launchgame"
		elseif button_press(350 + 128, 245, monde1,x,y,button) then
			niveau=1
			mode="launchgame"
			monde=2
		elseif button_press(700 + 128 + 42, 245, monde1,x,y,button) then
			niveau=1
			monde=3
			mode="launchgame"
		end
		if button =="l" then
			cursor=true
			cursorX=x
			cursorY=y
		else
			cursor=false
		end

	end
end

function love.keypressed(key)

	if mode=="play" then
		if move==false then
			if key=="kp+" then
				setvol(0.1)
			elseif key=="kp-" then
				setvol(-0.1)
			elseif key=="f1" then
				score=scorefinal
			elseif key=="f2" then
				if info==true then
					info=false
					--love.window.setMode( 1280, 720)
				else
					info=true
					--love.window.setMode( 1120, 768)
				end
			end
		end
		if (key == "q") then
			mode = "start"
		end
	end


end

function love.joystickpressed(joystick, key)

	if mode=="play" and key == 7 then
		mode ="start"
	end
end
