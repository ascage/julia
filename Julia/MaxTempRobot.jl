include("CoordRobot.jl")

mutable struct MaxTempRobot <: AbstractRobot
    robot :: CoordRobot
    max_temp :: Int
    coord_max_temp :: Tuple{Int, Int}
end

function HSR.move!(robot::MaxTempRobot, side)
    move!(robot.robot, side)
    if temperature(robot) > robot.max_temp
        robot.max_temp = temperature(robot)
        robot.coord_max_temp = get_coord(robot)
    end    
end

get_robot(robot :: MaxTempRobot) = get_robot(robot.robot)
get_coord(robot :: MaxTempRobot) = get_coord(robot.robot)
MaxTempRobot(robot::CoordRobot) = MaxTempRobot(robot, temperature(robot), get_coord(robot)) 