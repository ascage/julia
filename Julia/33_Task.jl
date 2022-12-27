include("MaxTempRobot.jl")
include("Recursion.jl")

function where_max_temp!(robot)
    robot = MaxTempRobot(CoordRobot(robot))
    labirint!(robot)
    coord = robot.coord_max_temp
    labirint!((robot) -> get_coord(robot)==coord, robot)
end