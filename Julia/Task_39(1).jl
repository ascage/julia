include("Functional.jl")
include("DirectRobot.jl")

try_move!(robot::DirectRobot, side) = move!(robot::DirectRobot, side) 

function inside_or_outside(robot)
    direct = where_border(robot) 
    direct_robot = DirectRobot(CoordRobot(robot), direct)
    move!(direct_robot, Nord)
    while get_direct(direct_robot) != direct || get_coord(direct_robot) != (0, 0)
        move!(direct_robot, Nord)
    end
    #along!((robot, side) -> (get_coord(robot) == (0,0) && get_direct(robot) == side ), direct_robot, get_direct(direct_robot))
    # step_direct_robot!(direct_robot)
    # while get_direct(direct_robot) != direct || get_coord(direct_robot) != (0, 0)
    #     step_direct_robot!(direct_robot)
    # end
    return get_in_or_out(direct_robot)
end

# function step_direct_robot!(direct_robot)
#     for side in (inverse(get_direct(direct_robot), 1), get_direct(direct_robot), inverse(get_direct(direct_robot), -1), inverse(get_direct(direct_robot), 2))
#         if !isborder(direct_robot, side)
#             move!(direct_robot, side)
#             break
#         end
#     end
# end

function where_border(robot)
    direct = Nord
    for side in (HS(i) for i in 0:3) 
        if isborder(robot, side) && !isborder(robot, inverse(side, 1))
            direct = inverse(side, 3)
        end
    end
    return direct
end