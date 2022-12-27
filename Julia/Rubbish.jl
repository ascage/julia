include("Functional.jl")

function along!(robot, side)::Nothing
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function num_steps_along!(robot, side)::Int
    num_steps = 0
    while !isborder(robot, side)
        move!(robot, side)
        num_steps += 1
    end
    return num_steps
end

function along!(robot, side, num_steps)::Nothing
    for i in 1:num_steps
        move!(robot, side)
    end
end

function try_move!(robot, side)::Bool
    if isborder(robot, side)
        return false
    else
        move!(robot, side)
        return true
    end
end
#try_move!(robot, direct) = (!isborder(robot, direct) && (move!(robot, direct); return true); false)

function nummarkers!(robot)
    side = Ost
    num_markers = nummarkers!(robot, side)
    while try_move!(robot, Nord)
        side = inverse(side, 2)
        num_markers += nummarkers!(robot, side)
    end
    along!(robot, West)
    along!(robot, Sud)
    return num_markers    
end

function nummarkers!(robot, side)
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

# function move_to_angle!(robot)
#     return (side = Nord, num_steps = num_steps_along!(robot, Sud)), (side = Ost, num_steps = num_steps_along!(robot, West)), (side = Nord, num_steps = num_steps_along!(robot, Sud))
# end
    
# function move_to_back!(robot, back_path)
#     for side in reverse(back_path)
#         along!(robot, side.side, side.num_steps)
#     end
# end

function movebypass!(robot, move_side)
    result = find_pass!(robot, move_side)
    move!(robot, move_side)
    along!(robot, result[1], result[2]-1)
    putmarker!(robot)
    move!(robot, result[1])
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

function move_to_angle!(robot, angle=(Sud,West))
    back_path = Vector{Tuple{HorizonSide,Int64}}()
    while !isborder(robot,angle[1]) || !isborder(robot, angle[2])
        push!(back_path, (inverse(angle[1], 2), num_steps_along!(robot, angle[1])))
        push!(back_path, (inverse(angle[2], 2), num_steps_along!(robot, angle[2]))) 
    end
    return back_path
end

function move_to_back!(robot, back_path)
    for derect in reverse(back_path)
        along!(robot, derect[1], derect[2])
    end
end

function numborders!(robot, side)
    num_borders = 0
    while space_pass!(robot, side)
        num_borders += 1
        border_pass!(robot, side) 
    end
    return num_borders
end

space_pass!(robot, side) = (along!(()->isborder(robot, Nord), robot, side); !isborder(robot, side))
border_pass!(robot, side) = along!(()->!isborder(robot, Nord), robot, side)

num_stepes_space_pass!(robot, side) = num_steps_along!(()->isborder(robot,Nord), robot, side)
border_pass!(robot, side) = along!(()->!isborder(robot, Nord), robot, side)

function numborders!(robot, side, gap_max)
    num_borders = 0
    numsteps_space_pass!(robot, side)
    while !isborder(robot, side)
        border_pass!(robot, side)
        gap = numsteps_space_pass!(robot, side)
        if isborder(robot, side)
            num_borders += 1
            break
        elseif gap < gap_max
            continue
        end
        num_borders += 1
    end
    return num_borders
end
    