include("CoordRobot.jl")

mutable struct MaxMin
    max :: Int
    min :: Int
end

struct MaxMinRobot <: AbstractRobot
    robot :: CoordRobot
    x_maxmin :: MaxMin
    y_maxmin :: MaxMin
end

function HSR.move!(robot :: MaxMinRobot, side :: HS)
    move!(robot.robot, side)
    if get_coord(robot)[1] > x_max(robot)
        robot.x_maxmin.max = get_coord(robot)[1]
    end
    if get_coord(robot)[1] < x_min(robot)
        robot.x_maxmin.min = get_coord(robot)[1]
    end
    if get_coord(robot)[2] > y_max(robot)
        robot.y_maxmin.max = get_coord(robot)[2]
    end
    if get_coord(robot)[2] < y_min(robot)
        robot.y_maxmin.min = get_coord(robot)[2]
    end
end

x_max(robot::MaxMinRobot) = robot.x_maxmin.max
x_min(robot::MaxMinRobot) = robot.x_maxmin.min
y_max(robot::MaxMinRobot) = robot.y_maxmin.max
y_min(robot::MaxMinRobot) = robot.y_maxmin.min

get_coord(robot::MaxMinRobot) = get_coord(robot.robot)
get_robot(robot::MaxMinRobot) = get_robot(robot.robot)

MaxMinRobot(robot::CoordRobot) = MaxMinRobot(robot, MaxMin(robot.coord.x, robot.coord.x), MaxMin(robot.coord.y, robot.coord.y))