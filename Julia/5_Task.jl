include("DirectBorderRobot.jl")
include("PutmarkersRobot.jl")
include("Functional.jl")

function around_marker!(robot)
    back_path = move_to_angle!(robot, (Sud, West))
    snake!((robot, side) -> isborder(robot, Nord), robot, (Ost, Nord))
    step!(robot, Ost)
    move_to_angle!(robot, (Sud, West))
    step!(robot, West)
    move_to_back!(robot, back_path)
end

function step!(robot, side)
    direct_robot = DirectBorderRobot(CoordRobot{PutmarkersRobot}(PutmarkersRobot(robot)), side)
    putmarker!(direct_robot)
    direct = side
    move!(direct_robot, side)
    along!((robot, side) -> (get_coord(robot) == (0,0) && get_direct(robot) == side ), direct_robot, direct)
end