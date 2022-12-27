include("CoordRobot.jl")
incluse("Recursion.jl")

function labirint!(robot)
    robot = CoordRobot(robot)
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