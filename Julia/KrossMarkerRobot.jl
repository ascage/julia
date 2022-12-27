include("CoordRobot.jl")

struct KrossMarkerRobot <:AbstractRobot
    robot :: CoordRobot
end

function HSR.move!(robot :: KrossMarkerRobot, side)
    move!(robot.robot, side)
    if get_coord(robot)[1] == get_coord(robot)[2] || get_coord(robot)[1] == -get_coord(robot)[2]
        putmarker!(robot)
    end
end

get_coord(robot :: KrossMarkerRobot) = get_coord(robot.robot)
get_robot(robot :: KrossMarkerRobot) = get_robot(robot.robot)