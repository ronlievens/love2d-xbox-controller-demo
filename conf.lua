function love.conf(t)
    t.window.title = "Joystick Tester" 	-- The window title (string)
    t.window.width = 1280              	-- The window width (number)
    t.window.height = 720              	-- The window height (number)
    t.window.vsync = true              	-- Enable vertical sync (boolean)
	t.window.msaa = 5					-- The number of samples to use with multi-sampled antialiasing (number)
    t.modules.touch = false           	-- Enable the touch module (boolean)

    --t.console = false                    -- Attach a console (boolean, Windows only; use only for debugging)
end