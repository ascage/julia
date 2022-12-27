include("Functional.jl")
include("DirectRobot.jl")

function inside_or_outside(robot)
    direct = where_border(robot) 
    direct_robot = DirectRobot(CoordRobot(robot), direct)
    move!(direct_robot, Nord)
    along!((robot, side) -> (get_coord(robot) == (0,0) && get_direct(robot) == side ), direct_robot, direct)
    return get_in_or_out(direct_robot)
end

function where_border(robot)
    direct = Nord
    for side in (HS(i) for i in 0:3) 
        if isborder(robot, side) && !isborder(robot, inverse(side, 1))
            direct = inverse(side, 3)
        end
    end
    return direct
end