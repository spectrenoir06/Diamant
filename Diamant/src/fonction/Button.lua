function button_draw(X,Y,image)

    love.graphics.draw( image, X, Y)
    
end

function button_press(X,Y,image,cursorX,cursorY,button)
    lY=image:getHeight()
    lX=image:getWidth()
    X2=lX+X
    Y2=lY+Y
    if cursorX > X and cursorX < X2 and cursorY > Y and cursorY < Y2 and button=="l" then
        touche=true
    else
        touche=false
    end
    
    return touche
end