include("ChessRobot.jl")
include("Recursion.jl")

function chess_labirint!(robot)
    robot = ChessRobot(robot)
    labirint!(robot)
end