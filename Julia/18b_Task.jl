include("AroundInfBorderRobot.jl")
include("8(17)_Task.jl")

function where_marker!(robot)
    robot = AroundInfBorderRobot(CoordRobot(robot))
    marker!(robot)
end