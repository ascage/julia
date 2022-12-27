include("Functional.jl")
include("CoordRobot.jl")

struct NChessRobot <: AbstractRobot
    robot :: CoordRobot
    n :: Int
end

function HSR.move!(robot :: NChessRobot, side)
    N = robot.n
    if mod(get_coord(robot)[1], 2*N) < N && mod(get_coord(robot)[2], 2*N) < N || mod(get_coord(robot)[1], 2*N) >= N && mod(get_coord(robot)[2], 2*N) >= N 
        putmarker!(robot)
    end
    move!(robot.robot, side)    
end

NChessRobot(robot::Robot, n) = NChessRobot(CoordRobot(robot), n)

get_robot(robot :: NChessRobot) = get_robot(robot.robot)
get_coord(robot :: NChessRobot) = get_coord(robot.robot)