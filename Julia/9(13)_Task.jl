include("ChessRobot.jl")

function chess!(robot)
    robot = ChessRobot(robot)
    back_path = move_to_angle!(robot, (Sud, West))
    snake!(robot, (Ost, Nord))
    if (get_coord(robot)[1]+get_coord(robot)[2]) % 2 == 0
        putmarker!(robot)
    end
    move_to_angle!(robot, (Sud, West))
    move_to_back!(robot, back_path)    
end