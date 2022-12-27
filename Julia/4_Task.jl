include("Functional.jl")

HorizonSideRobots.move!(robot, side::NTuple{2,HorizonSide}) = for i in side move!(robot, i) end
HorizonSideRobots.isborder(robot, side::NTuple{2,HorizonSide}) = isborder(robot, side[1]) || isborder(robot, side[2])
inverse(side::NTuple{2, HorizonSide}, n::Int) = inverse.(side, n)

function Kross!(robot)
    for side in ((Nord,West), (West, Sud), (Sud, Ost), (Ost, Nord))
        num_steps = numsteps_mark_along!(robot, side)
        side = inverse(side, 2)
        numsteps_along!(robot, side, num_steps)
    end
    putmarker!(robot)
end
