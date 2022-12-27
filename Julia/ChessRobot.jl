include("Functional.jl")
include("CoordRobot.jl")

struct ChessRobot <: AbstractRobot
    robot :: CoordRobot
end

function HSR.move!(robot :: ChessRobot, side)
    if (get_coord(robot)[1]+get_coord(robot)[2]) % 2 == 0
        putmarker!(robot)
    end
    move!(robot.robot, side)    
end

ChessRobot(robot) = ChessRobot(CoordRobot(robot))

get_robot(robot :: ChessRobot) = get_robot(robot.robot)
get_coord(robot :: ChessRobot) = get_coord(robot.robot)