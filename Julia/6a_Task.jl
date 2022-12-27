include("RectBorderRobot.jl")
include("2_Task.jl")


function square_border!(robot)
    robot = RectBorderRobot(robot)
    square!(robot)
end