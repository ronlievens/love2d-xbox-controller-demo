local elapsedTime = 0
local joysticks = {}
local colours = {{255,51,0,255},{51,255,0,255},{151,151,255,255},{255,0,255,255}}
local quads = {{x=10,y=60,w=620,h=320},{x=650,y=60,w=620,h=320},{x=10,y=390,w=620,h=320},{x=650,y=390,w=620,h=320}}

local function draw_debug_information()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("FPS=" .. tostring(love.timer.getFPS()), 10, 10)
end

local function draw_joystick(id)
	if  joysticks[id].device:isConnected() then
		love.graphics.setColor(colours[id][1], colours[id][2], colours[id][3])

		-- left top trigger
		love.graphics.rectangle("line", quads[id].x + 15, quads[id].y + 50, 25, 110)
		love.graphics.rectangle("fill", quads[id].x + 18, quads[id].y + 102 + joysticks[id].lt * 50, 19, 6)

		-- left top button
		love.graphics.rectangle("line", quads[id].x + 50, quads[id].y + 50, 100, 25)
		if joysticks[id].lb then
			love.graphics.rectangle("fill", quads[id].x + 52, quads[id].y + 52, 96, 21)
		end

		-- left stick
		love.graphics.circle("line", quads[id].x + 110, quads[id].y + 140, 50)
		love.graphics.circle("fill", quads[id].x + 110 + joysticks[id].lsh * 20, quads[id].y + 140 + joysticks[id].lsv * 20, 25)

		-- D-pad
		love.graphics.circle("line", quads[id].x + 185, quads[id].y + 220, 50)
		love.graphics.rectangle("line", quads[id].x + 172, quads[id].y + 170, 25, 100)
		love.graphics.rectangle("line", quads[id].x + 135, quads[id].y + 208, 100, 25)

		if joysticks[id].dpad == 'c' then
			love.graphics.rectangle("fill", quads[id].x + 174, quads[id].y + 210, 20, 20)
		elseif joysticks[id].dpad == 'u' then
			love.graphics.rectangle("fill", quads[id].x + 174, quads[id].y + 186, 20, 20)
		elseif joysticks[id].dpad == 'ru' then
			love.graphics.rectangle("fill", quads[id].x + 199, quads[id].y + 186, 20, 20)
		elseif joysticks[id].dpad == 'r' then
			love.graphics.rectangle("fill", quads[id].x + 199, quads[id].y + 210, 20, 20)
		elseif joysticks[id].dpad == 'rd' then
			love.graphics.rectangle("fill", quads[id].x + 199, quads[id].y + 235, 20, 20)
		elseif joysticks[id].dpad == 'd' then
			love.graphics.rectangle("fill", quads[id].x + 174, quads[id].y + 235, 20, 20)
		elseif joysticks[id].dpad == 'ld' then
			love.graphics.rectangle("fill", quads[id].x + 150, quads[id].y + 235, 20, 20)
		elseif joysticks[id].dpad == 'l' then
			love.graphics.rectangle("fill", quads[id].x + 150, quads[id].y + 210, 20, 20)
		elseif joysticks[id].dpad == 'lu' then
			love.graphics.rectangle("fill", quads[id].x + 150, quads[id].y + 186, 20, 20)
		end

		-- right top trigger	
		love.graphics.rectangle("line", quads[id].x + 465, quads[id].y + 50, 25, 110)
		love.graphics.rectangle("fill", quads[id].x + 468, quads[id].y + 102 + joysticks[id].rt * 50, 19, 6)

		-- right top button
		love.graphics.rectangle("line", quads[id].x + 355, quads[id].y + 50, 100, 25)
		if joysticks[id].rb then
			love.graphics.rectangle("fill", quads[id].x + 357, quads[id].y + 52, 96, 21)
		end

		-- right stick
		love.graphics.circle("line", quads[id].x + 295, quads[id].y + 220, 50)
		love.graphics.circle("fill", quads[id].x + 295 + joysticks[id].rsh * 20, quads[id].y + 220 + joysticks[id].rsv * 20,  25)

		-- back button
		love.graphics.rectangle("line", quads[id].x + 200, quads[id].y + 120, 25, 10)
		if joysticks[id].back then
			love.graphics.rectangle("fill", quads[id].x + 202, quads[id].y + 122, 21, 6)
		end

		-- start button
		love.graphics.rectangle("line", quads[id].x + 250, quads[id].y + 120, 25, 10)
		if joysticks[id].start then
			love.graphics.rectangle("fill", quads[id].x + 252, quads[id].y + 122, 21, 6)
		end

		-- Y buttons
		love.graphics.circle("line", quads[id].x + 370, quads[id].y + 105, 20)
		if joysticks[id].y then
			love.graphics.circle("fill", quads[id].x + 370, quads[id].y + 105, 18)
		end

		-- B button
		love.graphics.circle("line", quads[id].x + 410, quads[id].y + 135, 20)
		if joysticks[id].b then
			love.graphics.circle("fill", quads[id].x + 410, quads[id].y + 135, 18)
		end

		-- X button
		love.graphics.circle("line", quads[id].x + 335, quads[id].y + 140, 20)
		if joysticks[id].x then
			love.graphics.circle("fill", quads[id].x + 335, quads[id].y + 140, 18)
		end
		
		-- A Button
		love.graphics.circle("line", quads[id].x + 375, quads[id].y + 175, 20)
		if joysticks[id].a then
			love.graphics.circle("fill", quads[id].x + 375, quads[id].y + 175, 18)
		end

		-- Set all text
	    love.graphics.print(joysticks[id].device:getGUID() .. ": " .. joysticks[id].device:getName(), quads[id].x + 10, quads[id].y + 10)

	    -- print axes position
	    love.graphics.setColor(255, 255, 255)
	    love.graphics.print("Left stick H: " .. joysticks[id].lsh, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 150)
	    love.graphics.print("Left stick V: " .. joysticks[id].lsv, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 130)
	    love.graphics.print("Left Trigger: " .. joysticks[id].lt, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 110)
	    love.graphics.print("Right stick H: " .. joysticks[id].rsh, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 90)
	    love.graphics.print("Right stick V: " .. joysticks[id].rsv, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 70)
	    love.graphics.print("Right Trigger: " .. joysticks[id].rt, quads[id].x + quads[id].w - 218, quads[id].y + quads[id].h - 50)

		love.graphics.setColor(0, 0, 0)
		love.graphics.print(joysticks[id].device:getID(), quads[id].x + quads[id].w - 18, quads[id].y + quads[id].h - 20)
	end
end

local function check_joysticks_available() 

end

local function load_joysticks()
    for i, joystick in ipairs(love.joystick.getJoysticks()) do
		joysticks[i] = {
			device = joystick,
			binds = { 0,0,0,0,0,0},
			a = false,
			b = false,
			x = false,
			y = false,
			lb = false,
			tb = false,
			lt = 0,
			rt = 0,
			back = false,
			start = false,
			-- left axis
			lsh = 0,
			lsv = 0,
			--right axis
			rsh = 0,
			rsv = 0
		}
	end
end

-- 6 Axis: 1 tm 3 left 4 tm 6 is right
local function update_joystick()
	for i=1,#joysticks do
		joysticks[i].a = joysticks[i].device:isDown(1)
		joysticks[i].b = joysticks[i].device:isDown(2)
		joysticks[i].x = joysticks[i].device:isDown(3)
		joysticks[i].y = joysticks[i].device:isDown(4)

		joysticks[i].lb = joysticks[i].device:isDown(5)
		joysticks[i].rb = joysticks[i].device:isDown(6)

		joysticks[i].back = joysticks[i].device:isDown(7)
		joysticks[i].start = joysticks[i].device:isDown(8)

		joysticks[i].lsh=joysticks[i].device:getAxis(1)
		joysticks[i].lsv=joysticks[i].device:getAxis(2)
		joysticks[i].lt=joysticks[i].device:getAxis(3)

		joysticks[i].rsh=joysticks[i].device:getAxis(4)
		joysticks[i].rsv=joysticks[i].device:getAxis(5)
		joysticks[i].rt=joysticks[i].device:getAxis(6)

		joysticks[i].dpad = joysticks[i].device:getHat(1)
	end
end

function love.load()
	-- check avaible joysticks
   	load_joysticks()
end


function love.draw()
	-- draw quads border
	for i=1,#quads do
		love.graphics.setColor(colours[i][1], colours[i][2], colours[i][3])
		love.graphics.rectangle("line", quads[i].x, quads[i].y, quads[i].w, quads[i].h)
		love.graphics.rectangle("fill", quads[i].x + quads[i].w - 27, quads[i].y + quads[i].h -27, 25, 25)
	end

	for i=1,#joysticks do
		draw_joystick(i)
	end
	draw_debug_information()
end


function love.update(dt)
	elapsedTime = elapsedTime + dt

	if elapsedTime >= 0.1 then
		update_joystick()
		elapsedTime = 0
	end
end

-- https://love2d.org/wiki/KeyConstant
function love.keyreleased(key)
end

function love.keypressed(key)
end


-- Gamepad callback
function love.gamepadaxis( joystick, axis, value)
end

function love.joystickpressed(joystick,button)
end

-- This is a callback function
function love.joystickadded(joystick)
	if joystick:getID() > #joysticks and joystick:getID() < 5 then
		joysticks[joystick:getID()] = {
			device = joystick,
			binds ={0,0,0,0,0,0}
		}
	end
end