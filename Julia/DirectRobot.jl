include("CoordRobot.jl")
include("Functional.jl")

mutable struct DirectRobot <: AbstractRobot
    robot::CoordRobot
    direct::HS
    max_coord_y :: Int
    where_robot :: String
end

function HSR.move!(robot::DirectRobot, side::HS)
    for side in (inverse(get_direct(robot), 1), get_direct(robot), inverse(get_direct(robot), -1), inverse(get_direct(robot), 2))
        if !isborder(robot, side)
            move!(robot.robot, side)
            robot.direct = side
            break
        end
    end
    current = robot.robot.coord.y
    if current >= robot.max_coord_y
        robot.max_coord_y = current
        if isborder(robot, Nord)
            robot.where_robot = "inside"
        else
            robot.where_robot = "outside"
        end
    end
end

try_move!(robot::DirectRobot, side) = (move!(robot::DirectRobot, side); true)
DirectRobot(robot, direct) = DirectRobot(robot, direct, 0, "")
get_robot(robot::DirectRobot) = get_robot(robot.robot)
get_coord(robot::DirectRobot) = get_coord(robot.robot)
get_direct(robot::DirectRobot) = robot.direct
get_in_or_out(robot::DirectRobot) = robot.where_robot