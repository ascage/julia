include("RectBorderRobot.jl")
include("Functional.jl")

function kross!(robot)
    robot = RectBorderRobot(robot)
    for side in (HorizonSide(i) for i in 0:3)
        num_steps = num_steps_along!(robot, side)
        side = inverse(side, 2)
        putmarker!(robot)
        along!(robot, side, num_steps)
    end
end