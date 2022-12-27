include("NChessRobot.jl")

function N_chess!(robot, N)
    back_path = move_to_angle!(robot, (Sud, West))
    robot = NChessRobot(robot, N)
    snake!(robot, (Ost, Nord))
    if mod(get_coord(robot)[1], 2*N) < N && mod(get_coord(robot)[2], 2*N) < N || mod(get_coord(robot)[1], 2*N) >= N && mod(get_coord(robot)[2], 2*N) >= N 
        putmarker!(robot)
    end
    move_to_angle!(robot, (Sud, West))
    move_to_back!(robot, back_path)    
end