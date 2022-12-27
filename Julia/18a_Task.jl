include("RectBorderRobot.jl")
include("8(17)_Task.jl")

function where_marker!(robot)
    robot = RectBorderRobot(robot)
    marker!(robot)
end