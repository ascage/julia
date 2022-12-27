include("CoordRobot.jl")
include("Functional.jl")

mutable struct DirectBorderRobot <: AbstractRobot
    robot :: CoordRobot
    direct :: HS
end

function HSR.move!(robot::DirectBorderRobot, side::HS)
    for side in (inverse(get_direct(robot), 1), get_direct(robot), inverse(get_direct(robot), -1), inverse(get_direct(robot), 2))
        if !isborder(robot, side)
            move!(robot.robot, side)
            robot.direct = side
            break
        end
    end
end

try_move!(robot::DirectBorderRobot, side) = (move!(robot::DirectBorderRobot, side); true)
get_robot(robot::DirectBorderRobot) = get_robot(robot.robot)
get_coord(robot::DirectBorderRobot) = get_coord(robot.robot)
get_direct(robot::DirectBorderRobot) = robot.direct