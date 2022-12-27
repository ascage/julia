using HorizonSideRobots
HSR = HorizonSideRobots
HS = HorizonSide

abstract type AbstractRobot end

HSR.move!(robot::AbstractRobot, side) = move!(get_robot(robot), side)
HSR.isborder(robot::AbstractRobot, side) = isborder(get_robot(robot), side)
HSR.putmarker!(robot::AbstractRobot) = putmarker!(get_robot(robot))
HSR.ismarker(robot::AbstractRobot) = ismarker(get_robot(robot))
HSR.temperature(robot::AbstractRobot) = temperature(get_robot(robot))