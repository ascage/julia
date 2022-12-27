include("Functional.jl")
include("PutmarkersRobot.jl")

function full!(robot)
    back_path = move_to_angle!(robot, (West, Sud))
    robot = PutmarkersRobot(robot)
    snake!(robot, (Ost, Nord))
    move_to_angle!(robot, (West, Sud))
    move_to_back!(robot, back_path)
end