local ui = {name = "TEMPLATE"}

function ui.load(...) -- any args you want/need
end

-- Any "UI elements" that need to be drawn in that order.
-- UI elements can be little things like buttons, but also entire drawing functions.
ui.elements = {
}

-- Just some functions called by their respective main callbacks.
function ui.draw()
end

function ui.update(dt)
end

function ui.keypressed(key)
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
