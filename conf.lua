-- https://love2d.org/wiki/Config_Files
function love.conf(t)
    t.window.title = "LÖVE2D Xbox Controller Demo"
    t.window.width = 1280
    t.window.height = 720
    t.window.vsync = true
    t.window.msaa = 5
    t.modules.touch = false
end
