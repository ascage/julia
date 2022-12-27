include("AbstractRobot.jl")

struct RectBorderRobot{TupeRobot}
    robot:: TupeRobot
end

get_robot(robot::RectBorderRobot) = get_robot(robot.robot)
get_robot(robot::Robot) = robot

function try_move!(robot::RectBorderRobot, side)::Bool
    n=0
    while isborder(robot, side) && !isborder(robot, inverse(side, 1))
        move!(robot, inverse(side, 1))
        n += 1
    end
    if isborder(robot, side)
        along!(robot, inverse(side, 3), n)
        return false
    elseif n==0
        move!(robot, side)
        return true
    else
        move!(robot, side)
        while isborder(robot, inverse(side, 3))
            move!(robot, side)
        end
        along!(robot, inverse(side, 3), n-1)
        move!(robot, inverse(side, 3))
        return true
    end
end

RectBorderRobot(robot :: TupleRobot) where TupleRobot = RectBorderRobot{TupleRobot}(robot)

HSR.move!(robot::RectBorderRobot, side) = move!(robot.robot, side)
HSR.isborder(robot::RectBorderRobot, side) = isborder(robot.robot, side)
HSR.putmarker!(robot::RectBorderRobot) = putmarker!(robot.robot)
HSR.ismarker(robot::RectBorderRobot) = ismarker(robot.robot)
HSR.temperature(robot::RectBorderRobot) = temperature(robot.robot)