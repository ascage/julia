include("AbstractRobot.jl")

mutable struct CountMarkerRobot <: AbstractRobot
    robot :: Robot
    count :: Int
end

function HSR.move!(robot::CountMarkerRobot, side)
    move!(robot.robot, side)
    if ismarker(robot) 
        robot.count += 1
    end
end

CountMarkerRobot(robot::Robot) = CountMarkerRobot(robot::Robot, 0)

get_robot(robot::CountMarkerRobot) = robot.robot