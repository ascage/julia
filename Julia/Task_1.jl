function cross!(robot)
    for side in (HorizonSide(i) for i in 0 : 3)
        n=numsteps_putmarkers!(robot,side)
        along!(robot, side, n)
    end
    putmarker!(robot)
end
function numsteps_putmarkers!(robot, side)
    num_steps=0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        num_steps += 1
    end
    return num_steps 
end   
function along!(robot, side, n)
    side = HorizonSide(mod(Int(side)+2,4))
    for i in 1 : n
        move!(robot, side)
    end
end