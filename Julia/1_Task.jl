include("Functional.jl")

function Kross!(robot)
    for side in (Nord, West, Sud, Ost)
        num_steps = numsteps_mark_along!(robot, side)
        side = inverse(side, 2)
        numsteps_along!(robot, side, num_steps)
    end
    putmarker!(robot)
end