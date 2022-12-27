function square!(robot)
    n1 = num_along!(robot, Sud)
    n2 = num_along!(robot, West)
    n3 = num_along!(robot, Sud)
    cycle1!(robot, Ost)
    side = step!(robot, Ost)
    cycle2!(robot, side, Nord)
    k = num_along!(robot, Sud)
    k += num_along!(robot, West)
    k += num_along!(robot, Sud)
    if( n3 == 0 )
        for i in 1 : n2
            move!(robot, Ost)
        end
        for i in 1 : n1
            move!(robo, Nord)
        end
    else
        for i in 1 : (n1+n3)
            move!(robot, Nord)
        end
        for i in 1 : n2
            move!(robot, Ost)
        end
    end
end
function num_along!(robot, side:: HorizonSide)
    sum=0
    while( !isborder(robot, side) )
        move!(robot, side)
        sum+=1
    end
    return sum 
end
function cycle1!(robot, side::HorizonSide)
    for i in 0 : 3
        along_marker1!(robot, side)
        side=inverse!(side, 1)
    end
end
function inverse!(side, n::Int)
    return side = HorizonSide(mod(Int(side) + n, 4))
end
function along_marker1!(robot, side::HorizonSide)
    putmarker!(robot)
    while( !isborder(robot, side) )
        move!(robot, side)
        putmarker!(robot)
    end
end
function step!(robot, side::HorizonSide)
    while( !isborder(robot, Nord) )
        if( isborder(robot, side) )
            move!(robot, Nord)
            side = inverse!(side, 2)
        end
        move!(robot, side)
    end
    return side
end
function cycle2!(robot, side, side1)
    along_marker2!(robot, side, side1)
    move!(robot, side1)
    along_marker2!(robot, side1, inverse!(side, 2))
    move!(robot, inverse!(side, 2))
    along_marker2!(robot, inverse!(side, 2), inverse!(side1, 2))
    move!(robot, inverse!(side1, 2))
    along_marker2!(robot, inverse!(side1, 2), side)
end
function along_marker2!(robot, side::HorizonSide, side1)
    putmarker!(robot)
    while( isborder(robot, side1) )
        move!(robot, side)
        putmarker!(robot)
    end
end