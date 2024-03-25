
info = {
	name = "VVVVVV",
	author = "NyakoFox",
	description = "A theme which tries to make Ved look like VVVVVV's editor."
}

function draw_nineslice(asset, x, y, x2, y2)
	local low_x = math.min(x, x2)
	local low_y = math.min(y, y2)
	local high_x = math.max(x, x2)
	local high_y = math.max(y, y2)

	if (asset.name == "ui/placing_script" or asset.name == "ui/placing_enemy_bounds" or asset.name == "ui/placing_platform_bounds") then
		love.graphics.setLineWidth(2)
		love.graphics.setColor(210 + v6_help.glow / 2, 191 + v6_help.glow, 255 - v6_help.glow / 2)
		love.graphics.rectangle("line", low_x + 1, low_y + 1, high_x - low_x - 2, high_y - low_y - 2)
		love.graphics.setColor(105 + v6_help.glow / 4, 100 + v6_help.glow / 2, 128 - v6_help.glow / 4)
		love.graphics.rectangle("line", low_x + 4 + 1, low_y + 4 + 1, high_x - low_x - 8 - 2, high_y - low_y - 8 - 2)
		love.graphics.setColor(255,255,255)
		love.graphics.setLineWidth(1)
		return true
	end

	if (asset.name == "ui/enemy_bounds") then
		love.graphics.setLineWidth(2)
		love.graphics.setColor(255 - (v6_help.glow / 2), 64, 64)
		love.graphics.rectangle("line", low_x + 1, low_y + 1, high_x - low_x - 2, high_y - low_y - 2)
		love.graphics.setColor(255, 255, 255)
		love.graphics.setLineWidth(1)
		return true
	end

	return false
end
