function full!(robot)
    for side in (HorizonSide(i) for i in 0 : 3)
        n=numsteps_putmarkers!(robot,side)
        along!(robot, side, n)
    end
    square!(robot)
    putmarker!(robot)
end
function square!(robot)
    for side in (HorizonSide(i)  for i in 0 : 3)
        if( zd!(robot,side) )
            n=numsteps_putmarkers!(robot, side)
            for i ∈ 0 : n
                put!(robot, side)
            end
            move!(robot, HorizonSide(mod(Int(side)+3,4)))
        end
    end
end
function put!(robot, side)
    sum=numsteps_putmarkers!(robot, HorizonSide(mod(Int(side)+1,4)))
    along!(robot, HorizonSide(mod(Int(side)+1,4)), sum)
    putmarker!(robot)
    move!(robot, HorizonSide(mod(Int(side)+2,4)))
end
function zd!(robot, side)
    if( !isborder(robot, side) && !isborder(robot, HorizonSide(mod(Int(side)+1,4))) )
        move!(robot, side)
        move!(robot, HorizonSide(mod(Int(side)+1,4)))
        return true
    else
        return false
    end 
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