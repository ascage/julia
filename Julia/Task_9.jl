function chess!(robot)
    n = along!(robot, Sud)
    m = along!(robot, West)
    full!(robot, Ost, mod(n+m, 2))
    along!(robot, West)
    along!(robot, Sud)
    for i in 1 : n+m
        if( i < n+1 )
            move!(robot, Nord)
        else
            move!(robot, Ost)
        end
    end
end
function along!(robot, side)
    sum = 0
    while ( !isborder(robot, side) )
        move!(robot, side)
        sum+=1
    end    
    return sum
end
function full!(robot, side, n)
    while ( !isborder(robot, side) || !isborder(robot, Nord) )
        if( n==0 )
            putmarker!(robot)
        end
        if( !isborder(robot, side) )
            move!(robot, side)
        else
            move!(robot, Nord)
            side = inverse!(side, 2)
        end
        n = mod(n+1, 2)
    end
    if( n==0 )
        putmarker!(robot)
    end
end
function inverse!(side, n::Int)
    return side = HorizonSide(mod(Int(side)+n, 4))
end