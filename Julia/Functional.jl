try_move!(robot, direct) ::Bool = (!isborder(robot, direct) && (move!(robot, direct); return true); false)

function along!(robot, side)::Nothing
    while try_move!(robot, side)
    end
end

function num_steps_along!(robot, side)::Int
    num_steps = 0
    while try_move!(robot, side)
        num_steps += 1
    end
    return num_steps
end

function along!(robot, side, num_steps)::Nothing
    for i in 1:num_steps
        try_move!(robot, side)
    end
end

function numsteps_along!(robot, side, max_num_steps)::Int
    num_steps = 0
    while (num_steps < max_num_steps) && try_move!(robot, side)
        num_steps += 1
    end
    return num_steps
end

function inverse(side, n :: Int)::HorizonSide
    return HorizonSide(mod(Int(side) + n, 4))                     #Nord=0, West=1, Sud=2, Ost=3
end

function nummarkers!(robot, side)::Int
    num_markers = Int(ismarker(robot))
    while try_move!(robot, side)
        if ismarker(robot)
            num_markers += 1
        end
    end
    return num_markers
end

function numsteps_mark_along!(robot, side)::Int
    num_steps = 0
    while try_move!(robot, side)
        putmarker!(robot)
        num_steps += 1
    end
    return num_steps
end

function find_pass!(robot, border_side) 
    num_steps = 0
    bypass_side = inverse(border_side, 1)
    while isborder(robot, border_side)
        num_steps += 1
        along!(robot, bypass_side, num_steps)
        bypass_side = inverse(bypass_side, 2)
    end
    return (bypass_side, div(num_steps, 2) + 1) 
end

function move_to_angle!(robot, angle::Tuple{HorizonSide, HorizonSide})
    back_path = Vector{Tuple{HorizonSide,Int}}()
    while !isborder(robot,angle[1]) || !isborder(robot, angle[2])
        push!(back_path, (inverse(angle[1], 2), num_steps_along!(robot, angle[1])))
        push!(back_path, (inverse(angle[2], 2), num_steps_along!(robot, angle[2]))) 
    end
    return back_path
end

function move_to_back!(robot, back_path::Vector{Tuple{HorizonSide, Int}})::Nothing
    for derect in reverse(back_path)
        along!(robot, derect[1], derect[2])
    end
end

function num_horizontal_borders!(robot, side)::Int
    num_borders = 0
    state = 0
    while try_move!(robot, side)
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

function num_horizontal_Nborders!(robot, side, N)::Int
    num_borders = 0
    state = 0
    while try_move!(robot, side)
        if state == 0
            if isborder(robot, Nord)
                state = 1
            end
        elseif state == N+1
            if !isborder(robot, Nord)
                state = 0
                num_borders +=1
            else
                state = 1
            end
        else
            if isborder(robot, Nord)
                state = 1
            else
                state +=1
            end
        end
    end
    if state > 1 
        num_borders +=1
    end
    return num_borders
end

function try_move_borders!(robot, side)::Bool
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
        while isborder(robot, inverse(side, 3)) && n > 0
            move!(robot, side)
        end
        along!(robot, inverse(side, 3), n)
        return true
    end
end

function along!(stop_condition::Function, robot, side)::Nothing
    while !stop_condition(robot, side) && try_move!(robot, side)
    end
end

function num_steps_along!(stop_condition::Function, robot, side)::Int
    num_steps = 0
    while !stop_condition(robot, side) && try_move!(robot, side)
        num_steps += 1
    end
    return num_steps
end

function along!(stop_condition::Function, robot, side, num_steps)::Int
    n = 0
    while n < num_steps && !stop_condition(robot, side) && try_move!(robot, side)
        n += 1
    end 
    return n
end

function shuttle!(stop_condition::Function, robot, side)
    n = 0
    while !stop_condition(robot, side) 
        n += 1
        along!(robot, side, n)
        side = inverse(side, 2)
    end
end

function spiral!(stop_condition::Function, robot, (side1, side2)::Tuple{HorizonSide, HorizonSide} )
     n = 1
     k = mod(Int(side2)-Int(side1), 4)
    along_!(side, n) = along!( (robot, side) -> stop_condition(robot, side), robot, side, n)
    while !stop_condition(robot, side1)
        along_!(side1, n)
        if stop_condition(robot, side1)
            continue
        end
        side1 = inverse(side1, k)
        along_!(side1, n)
        if stop_condition(robot, side1)
            continue
        end
        side1 = inverse(side1, k)
        n += 1
    end
end

function snake!(stop_condition::Function, robot, (move_side, next_row_side)::Tuple{HorizonSide,HorizonSide}) 
    along!((robot, direct) -> stop_condition(robot, direct), robot, move_side)
    move_side = inverse(move_side, 2)
    while !stop_condition(robot, move_side) && try_move!(robot, next_row_side)
        along!((robot, direct) -> stop_condition(robot, direct), robot, move_side)
        move_side = inverse(move_side, 2)
    end
end

function snake!(robot, (move_side, next_row_side)::Tuple{HorizonSide,HorizonSide}) 
    along!(robot, move_side)
    move_side = inverse(move_side, 2)
    while try_move!(robot, next_row_side)
        along!(robot, move_side)
        move_side = inverse(move_side, 2)
    end
end