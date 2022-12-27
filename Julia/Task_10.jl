function N_chess!(robot, N::Int)
    n = along!(robot, Sud)
    m = along!(robot, West)   
    height = 0
    full_line!(robot, N, 1)
    while ( !isborder(robot, Nord) )
        move!(robot, Nord)
        height = mod(height+1, 2*N)
        if( height < N)
            full_line!(robot, N, 1)
        else
            full_line!(robot, N, 2)
        end
    end
    along!(robot, West)
    along!(robot, Sud)
    for i in 1 : n+m
        if ( i <= n )
            move!(robot, Nord)
            move!(robot, Ost)
        end
    end
end
function along!(robot, side)
    sum = 0
    while( !isborder(robot, side) )
        move!(robot, side)
        sum += 1
    end
    return sum
end
function full_line!(robot, N, log::Int)
    n = 0
    while ( !isborder(robot, Ost) )
        if( n < N*log && n >= N*(log-1) )
            putmarker!(robot)
        end 
        move!(robot, Ost)
        n = mod(n+1, 2*N)
    end
    if( n < N*log && n >= N*(log-1) )
        putmarker!(robot)
    end
    along!(robot, West)
end