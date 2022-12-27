function square!(robot)
    for side in (HorizonSide(i) for i in 0 : 3)
        n=numsteps!(robot, side)
        putmarker_border!(robot,side)
        putmarker!(robot)
        along!(robot, side, n) 
    end
end
function numsteps!(robot, side)
    sum=0
    while !isborder(robot, side)
        move!(robot, side)
        sum+=1
    end
    return sum
end
function putmarker_border!(robot, side)
    side = HorizonSide(mod(Int(side)+1,4))
    num=numsteps_putmarkers!(robot, side)
    along!(robot, side, num)   
    side = HorizonSide(mod(Int(side)+2,4))
    num=numsteps_putmarkers!(robot, side)
    along!(robot, side, num)
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