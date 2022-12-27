include("Functional.jl")

function num_horizontal_Nborders!(robot, N)
    back_path = move_to_angle!(robot, (Sud, West))
    side = Ost
    num_borders = num_horizontal_Nborders!(robot, side, N)
    while try_move!(robot, Nord)
        side = inverse(side, 2)
        num_borders += num_horizontal_Nborders!(robot, side, N)
    end
    move_to_angle!(robot, (Sud, West))
    move_to_back!(robot, back_path)
    return num_borders
end 