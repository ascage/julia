include("AbstractRobot.jl")

abstract type AbstractCoordsRobot <: AbstractRobot end

function HSR.move!(robot::AbstractCoordsRobot, side::HorizonSide)
    move!(get_robot(robot), side)
    x, y = get_coords(robot)
    if side==Nord
        set_coords(robot, x, y+1)
    elseif side==Sud
        set_coords(robot, x, y-1)
    elseif side==Ost
        set_coords(robot, x+1, y)
    else 
        set_coords(robot,x-1, y)
    end
end
