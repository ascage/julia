include("Functional.jl")

function line!(robot)
    shuttle!((robot, side) -> !isborder(robot, Nord), robot, Ost)
    move!(robot, Nord)
end