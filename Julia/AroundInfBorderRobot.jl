include("CoordRobot.jl")
include("Functional.jl")

struct AroundInfBorderRobot <: AbstractRobot
    robot :: CoordRobot
end

function try_move!(robot::AroundInfBorderRobot, side::HS)
    if !isborder(robot, side)
        move!(robot.robot, side)
    else
        coord = get_coord(robot)
        direct = side
        shuttle!((robot, side) -> !isborder(robot, direct), robot, inverse(side, 1))
        coord = (coord[1] - get_coord(robot)[1], coord[2] - get_coord(robot)[2] )
        move!(robot.robot, side)
        side , num_steps = where_go(coord)
        along!(robot.robot, side, num_steps)
    end
    return true
end

function where_go(coord :: Tuple{Int, Int})
    side = Nord
    num_steps = 0
    if coord[1] == 0
        if coord[2] > 0
            side = Nord
            num_steps = coord[2]
        else
            side = Sud
            num_steps = -coord[2]
        end
    elseif coord[1] > 0
        side = Ost
        num_steps = coord[1]
    else
        side = West
        num_steps = -coord[1]
    end
    return side, num_steps
end

get_coord(robot::AroundInfBorderRobot) = get_coord(robot.robot)
get_robot(robot::AroundInfBorderRobot) = get_robot(robot.robot)
