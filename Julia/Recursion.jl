include("Functional.jl")

function tolim!(robot, side)                   #19
    if !isborder(robot, side)
        move!(robot, side)
        tolim!(robot, side)
    end
end

function marklim!(robot, side)     #20
    if isborder(robot, side)
        putmarker!(robot)
    else
        move!(robot, side)
        marklim!(robot, side)
        move!(robot, inverse(side, 2))
    end
end

function step!(robot, side)           #21
    if !isborder(robot, side)
        move!(robot, side)
    else
        move!(robot, inverse(side, 1))
        step!(robot, side)
        move!(robot, inverse(side, 3))
    end
end

# function doubledist!(robot, side)                          #22
#     if !isborder(robot,side)
#         move!(robot,side)
#         doubledist!(robot, side)
#         move!(robot,inverse(side, 2))
#         move!(robot, inverse(side, 2))
#     end
# end

function doubledist!(robot, side)  ::Bool                        #22
    if !isborder(robot,side)
        move!(robot,side)
        if doubledist!(robot, side) && try_move!(robot,inverse(side, 2)) && try_move!(robot, inverse(side, 2))
            return true
        else
            return false
        end
    end
    return true
end
    
function to_symmetric_position(robot, side)                             #23
    if !isborder(robot, side)
        move!(robot, side)
        to_symmetric_position(robot, side)
        move!(robot,side)
    else
        step!(robot, side)
    end
end

function halfdist!(robot, side)                               #24
    if !isborder(robot, side)
        move!(robot, side)
        no_delayed_action!(robot, side)
        move!(robot, inverse(side,2))
    end
end
function no_delayed_action!(robot,side)
    if !isborder(robot, side)
        move!(robot, side)
        halfdist!(robot, side)
    end
end
    
function chess_line_0!(robot, side)                 #25a
    putmarker!(robot)
    if !isborder(robot, side)
        move!(robot, side)
        steps_0!(robot, side)            
    end
end
function steps_0!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        chess_line_0!(robot, side)
    end    
end

function chess_line_1!(robot, side)                 #25b
    if !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        steps_1!(robot, side)            
    end
end
function steps_1!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        chess_line_1!(robot, side)
    end    
end

function mark_labirint!(robot)                         #26 (29b)
    if !ismarker(robot)
        putmarker!(robot)
        for side in (Nord, West, Sud, Ost)
            if !isborder(robot, side)
                move!(robot, side)
                mark_labirint!(robot)
                move!(robot, inverse(side, 2))
            end
        end
    end   
end

function sum_vector(vector::Vector{T}, s::T) where T                   #27
    if length(vector) == 0
        return s
    else
        return sum_vector(vector[1:end-1]) + vector[end]
    end
end
sum_vector(vector::Vector{T}) where T = sum_vector(vector, zero(eltype(vector)))

function labirint!(robot)
    passed_coordinates = Set{Tuple{Int, Int}}() 
    function recursive_traversal!()
        if !(get_coord(robot) in passed_coordinates)
            push!(passed_coordinates, get_coord(robot))
            for side in (Nord, West, Sud, Ost)
                if try_move!(robot, side)
                    recursive_traversal!()
                    move!(robot, inverse(side, 2))
                end
            end
        end
    end
    recursive_traversal!()
    return passed_coordinates
end

function labirint!(stop_condition::Function, robot)
    passed_coordinates = Set{Tuple{Int, Int}}() 
    function recursive_traversal!()
        if stop_condition(robot)
            throw("true")
        end
        if !(get_coord(robot) in passed_coordinates)
            push!(passed_coordinates, get_coord(robot))
            for side in (Nord, West, Sud, Ost)
                if try_move!(robot, side)
                    recursive_traversal!()
                    move!(robot, inverse(side, 2))
                end
            end
        end
    end
    recursive_traversal!()
    return passed_coordinates
end

# function memoize_fibonacci(n::Int)
#     dict = Dict{Int,Int}() 
#     dict[1], dict[2] = 1, 1
#     function fib_recurs(n)
#         if n <= 2
#             return 1
#         end
#         if n-2 in dict.keys
#             f_prevprev = dict[n-2]
#         else
#             f_prevprev = fib_recurs(n-2)                           
#             dict[n-2] = f_prevprev
#         end
#         if n-1 in dict.keys
#             f_prev = dict[n-1]
#         else
#             f_prev = fib_recurs(n-1)
#             dict[n-1] = f_prev
#         end
#         return f_prevprev + f_prev
#     end
#     return fib_recurs(n)
# end

function fibonacci_b(n)                            #28b
    if n < 3 
        return 1
    else
        return fibonacci_b(n-1) + fibonacci_b(n-2)
    end
end

function fibonacci_c(n)                            #28c
    if n == 0 
        return 1, 0
    else
        current, prev = fibonacсi(n-1)
        return prev+current, current
    end
end

function fibonacci_a(n::Int)                          #28a
    f_first, f_second = 1, 1
    for i in 1:n-2
        f = f_second 
        f_second += f_first
        f_first = f
    end
    return f_second
end

function labirint_mark!(robot)                         #29a
    if !ismarker(robot)
        putmarker!(robot)
        for side in (Nord, West, Sud, Ost)
            if try_move_marker!(robot, side)
                labirint_mark!(robot)
                move!(robot, inverse(side, 2))
            end
        end
    end   
end
function try_move_marker!(robot, side) :: Bool
    if try_move!(robot, side)
        if ismarker(robot)
            move!(robot, inverse(side, 2))
            return false
        end
        return true
    end
    return false
end
    