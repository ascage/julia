include("KrossMarkerRobot.jl")
include("Recursion.jl")

function kross_labirint!(robot)
    robot = KrossMarkerRobot(CoordRobot(robot))
    labirint!(robot)
end