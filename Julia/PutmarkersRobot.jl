include("AbstractRobot.jl")

struct PutmarkersRobot <: AbstractRobot
    robot :: Robot
end

function HSR.move!(robot::PutmarkersRobot, side)
    move!(robot.robot, side)
    putmarker!(robot)
end

get_robot(robot::PutmarkersRobot) = robot.robot