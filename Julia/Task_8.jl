function marker!(robot)
    side = Ost
    k=0
    n=0
    step=1
    while( !ismarker(robot) )
        move!(robot, side)
        n+=1
        if( n==step )
            n=0
            side = inverse!(side, 1)
            step+=k
            k=mod(k+1, 2)
        end
    end
end
function inverse!(side, n::Int)
    return side = HorizonSide(mod(Int(side)+n, 4))
end