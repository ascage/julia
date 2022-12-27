include("CoordRobot.jl")

function N_chess!(robot, N::Int)
    coord_robot = CoordRobot(robot)
    snake!(coord_robot, N)
end

function snake!(coord_robot, N)
    side = Ost
    if( mod(coord_robot.coord.x, 2*N) < N && mod(coord_robot.coord.y, 2*N) < N || mod(coord_robot.coord.x, 2*N) >= N && mod(coord_robot.coord.y, 2*N) >= N )
        putmarker!(coord_robot)
    end
    while( true )
        if( !isborder(coord_robot, side) )
            move!(coord_robot, side)
        elseif ( !isborder(coord_robot, Nord) )
            move!(coord_robot, Nord)
            side = inverse!(side)
        else
            break
        end
        if( mod(coord_robot.coord.x, 2*N) < N && mod(coord_robot.coord.y, 2*N) < N || mod(coord_robot.coord.x, 2*N) >= N && mod(coord_robot.coord.y, 2*N) >= N )
            putmarker!(coord_robot)
        end
    end
end

function inverse!(side)
    return side = HorizonSide(mod(Int(side)+2, 4))
end