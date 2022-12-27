include("Functional.jl")
include("RectBorderRobot.jl")
include("PutmarkersRobot.jl")

function put_marker!(robot)
    robot = RectBorderRobot{PutmarkersRobot}(PutmarkersRobot(robot))
    putmarker!(robot)
    snake!(robot, (Ost, Nord))
end