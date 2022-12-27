include("AbstractRobot.jl")

mutable struct Coordinates
    x::Int
    y::Int
end

Coordinates() = Coordinates(0,0)

function HSR.move!(coord::Coordinates, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    elseif side==West
        coord.x -= 1
    end
end

get_coord(coord::Coordinates) = (coord.x, coord.y)

struct CoordRobot{TupleRobot} <: AbstractRobot 
    robot::TupleRobot
    coord::Coordinates
end

CoordRobot(robot::TupleRobot) where TupleRobot = CoordRobot{TupleRobot}(robot, Coordinates()) 

function HSR.move!(robot::CoordRobot, side)
    move!(robot.robot, side)
    move!(robot.coord, side)
end

get_coord(robot::CoordRobot) = get_coord(robot.coord)

get_robot(robot::CoordRobot) = get_robot(robot.robot)

get_robot(robot::Robot) = robot