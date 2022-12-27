include("Functional.jl")
function square!(robot)
    for side in (HorizonSide(i) for i in 0:3)
        num_steps = num_steps_along!(robot, side)
        mark_side!(robot, side)
        side = inverse(side, 2)
        along!(robot, side, num_steps)
    end
end
function mark_side!(robot, side)::Nothing
    side = inverse(side, 1)
    for _ in 0:1
        num_steps = numsteps_mark_along!(robot, side)
        side = inverse(side, 2)
        along!(robot, side, num_steps)
    end
    putmarker!(robot)
end