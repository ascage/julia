function line!(robot)
    x=1
    side = Ost
    while( isborder(robot, Nord) )
        along!(robot, side, x)
        side=inverse!(side)
        x+=1
    end
    move!(robot, Nord)
end
function along!(robot, side, x)
    for i in 1 : x
        move!(robot, side)
    end
end
function inverse!(side)
    return side = HorizonSide(mod(Int(side)+2, 4))
end