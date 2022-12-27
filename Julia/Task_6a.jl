function square!(robot)
    for side in (HorizonSide(i) for i in 0:3)
        n=0
        log=1
        while ( true )
            n += along!(robot, side) 
            k , log = around_border!(robot, side)
            n += k
            if( !Bool(log) )
                break
            end
        end
        full_marker!(robot, side)
        while( n>0 )
            if( !isborder(robot, inverse!(side, 2)) )
                move!(robot, inverse!(side, 2))
                n -= 1
            else
                k , log = around_border!(robot, inverse!(side, 2))
                n -= k
            end
        end
    end
end
function along!(robot, side)
    n=0
    while( !isborder(robot, side) )
        move!(robot, side)
        n += 1
    end
    return n
end
function around_border!(robot, side)
    flank = 0
    front = 0
    log = 1
    while( isborder(robot, side) )
        if( !isborder(robot, inverse!(side, 1)) )
            flank += 1
            move!(robot, inverse!(side, 1))
        else
            log = 0
            break
        end
    end
    if ( Bool(log) )
        move!(robot, side)
        front += 1
        while( isborder(robot, inverse!(side, 3)) )
            move!(robot, side)
            front +=1
        end
    end
    aalong!(robot, inverse!(side, 3), flank)
    return front, log
end
function aalong!(robot, side, n)
    for i in 1 : n
        move!(robot, side)
    end
end
function inverse!(side, n :: Int)
    return side=HorizonSide(mod(Int(side)+n, 4))    
end
function full_marker!(robot, side)
    n1 = along!(robot, inverse!(side, 1))
    for i in 1 : n1
        putmarker!(robot)
        move!(robot, inverse!(side, 3))
    end
    n2 = along!(robot, inverse!(side, 3))
    for i in 1 : n2
        putmarker!(robot)
        move!(robot, inverse!(side, 1)) 
    end
    putmarker!(robot)
end