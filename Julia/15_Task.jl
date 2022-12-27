include("RectBorderRobot.jl")
include("KrossMarkerRobot.jl")
include("Functional.jl")

function Kross_border!(robot)
    robot = RectBorderRobot(KrossMarkerRobot(CoordRobot(robot)))
    back_path = move_to_angle!(robot, (Sud, West))
    snake!(robot, (Ost, Nord))
    move_to_angle!(robot, (Sud, West))
    move_to_back!(robot, back_path)
end