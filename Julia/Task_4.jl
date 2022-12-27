function Kross!(robot)
    for side in (HorizonSide(i) for i in 0 : 3)
        n=0
        while ( step!(robot, side) )
            putmarker!(robot)
            n+=1
        end
        return!(robot, side, n)
    end
    putmarker!(robot)
end
function step!(robot, side)
    if ( !isborder(robot, side) && !isborder(robot, HorizonSide(mod(Int(side)+1,4))) )
        move!(robot, side)
        move!(robot, HorizonSide(mod(Int(side)+1,4))) 
        return true
    else
        return false
    end
end
function return!(robot, side, n)
    for i in 0 : n-1
        move!(robot, HorizonSide(mod(Int(side)+2 , 4)))
        move!(robot, HorizonSide(mod(Int(side)+3 , 4)))
    end
end