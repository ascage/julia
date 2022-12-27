include("Functional.jl")
include("RectBorderRobot.jl")
include("CountMarkerRobot.jl")

# function count_marker!(robot)
#     back_path = move_to_angle!(robot, (West, Sud))
#     robot = RectBorderRobot{CountMarkerRobot}(CountMarkerRobot(robot))
#     snake!(robot, (Ost, Nord))
#     move!(get_robot(robot), back_path)
#     return robot.robot.count
# end