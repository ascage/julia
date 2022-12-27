include("CoordRobot.jl")
function get_coord_markers!(robot)
    coord_robot = CoordRobot(robot)
    side = Ost
    coord_markers = get_coord_markers!(coord_robot, side)
    while !isborder(coord_robot, Nord)
        move!(coord_robot, Nord)
        side = inverse(side)
        coord_markers=vcat(coord_markers, get_coord_markers!(coord_robot, side))
    end
    return coord_markers
end

function get_coord_markers!(coord_robot, side)
    coord_markers = Vector{Tuple{Int64,Int64}}() 
    if ismarker(coord_robot)
        push!(coord_markers, get_coord(coord_robot))
    end
    while !isborder(coord_robot, side)
        move!(coord_robot, side)
        if ismarker(coord_robot)
            push!(coord_markers, get_coord(coord_robot))
        end
    end
    return coord_markers
end
function inverse(side)
    return side = HorizonSide(mod(Int(side)+2, 4))    
end