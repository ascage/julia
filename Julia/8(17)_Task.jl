include("Functional.jl")

function marker!(robot)
    spiral!((robot, side) -> ismarker(robot), robot, (Ost, Nord))
end