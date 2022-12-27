include("Functional.jl")

function num_borders!(robot)
    back_path = move_to_angle!(robot, (Sud, West))
    side = Ost
    num_borders = num_borders!(robot, side)
    while try_move!(robot, Nord)
        side = inverse(side, 2)
        num_borders += num_borders!(robot, side)
    end
    move_to_angle!(robot, (Sud, West))
    move_to_back!(robot, back_path)
    return num_borders
end
function num_borders!(robot, side)
    function local_try_move_borders!(robot, side)::Bool
        n=0
        while isborder(robot, side) && !isborder(robot, inverse(side, 1))
            move!(robot, inverse(side, 1))
            n += 1
        end
        if isborder(robot, side)
            along!(robot, inverse(side, 3), n)
            return false
        else
            move!(robot, side) 
            if n == 1 && !isborder(robot,Nord)
                num_borders += 1
            end 
            while isborder(robot, inverse(side, 3)) && n > 0
                move!(robot, side)
            end
            along!(robot, inverse(side, 3), n)
            return true
        end
    end
    num_borders = 0
    state = 0 
    while try_move_borders!(robot, side)
        if state == 0
            if isborder(robot, Nord)
                state = 1 
            end
        else
            if !isborder(robot, Nord) 
                state = 0
                num_borders += 1
            end
        end
    end
    return num_borders
end    