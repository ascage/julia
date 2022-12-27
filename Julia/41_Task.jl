include("Recursion.jl")
include("MaxMinRobot.jl")

function how_mani_labirints(robot)
    robot = MaxMinRobot(CoordRobot(robot))
    coordinates = labirint!(robot)
    size_y , size_x = y_max(robot) - y_min(robot) + 3, x_max(robot) - x_min(robot) + 3
    labirint = convert(Matrix{Int}, zeros( size_y, size_x))
    for coord in coordinates
        labirint[ coord[2] - y_min(robot) + 2, coord[1] - x_min(robot) + 2 ] = 1
    end
    labirint = matrix_borders!(labirint, size_y, size_x)
    labirint = around_border!(labirint, size_y, size_x)
    sum_labirints = 0
    for i in 3 : size_y-2
        labirint, sum = line!(labirint, i, size_x)
        sum_labirints += sum
    end
    return sum_labirints
end

function line!(matrix, n, m)
    sum = 0
    for i in 3 : m-2
        if matrix[n, i] == 0
            sum += 1
            matrix, coord = matrix_0_1(matrix, (n, i))
        end
    end
    return matrix, sum
end

function around_border!(matrix, n, m)
    for i in 2 : m-1
        matrix , coord = matrix_0_1(matrix, (2, i))
        matrix , coord = matrix_0_1(matrix, (n-1, i))
    end
    for i in 2 : n-1
        matrix , coord = matrix_0_1(matrix, (i, 2))
        matrix , coord = matrix_0_1(matrix, (i, m-1))
    end
    return matrix
end

function matrix_borders!(matrix, n::Int, m::Int)
    for i in 1 : n
        matrix[i, 1], matrix[i, m] = 1, 1
    end
    for i in 1 : m
        matrix[1, i], matrix[n, i] = 1, 1
    end 
    return matrix
end

function matrix_0_1(matrix , coordinates :: Tuple{Int, Int})
    element(matrix, coordinates) = matrix[coordinates[1], coordinates[2]]
    if matrix[coordinates[1], coordinates[2]] == 0
        matrix[coordinates[1], coordinates[2]] = 1
        for side in (Nord, West, Sud, Ost)
            if element(matrix, move!(coordinates, side)) == 0
                coordinates = move!(coordinates, side)
                matrix, coordinates = matrix_0_1(matrix, coordinates)
                coordinates = move!(coordinates, inverse(side, 2))
            end
        end
    end
    return matrix, coordinates
end

function HSR.move!(coordinates :: Tuple{Int, Int}, side :: HS)
    if side == Nord
        coordinates = (coordinates[1] - 1, coordinates[2])
    end
    if side == Sud
        coordinates = (coordinates[1] + 1, coordinates[2])
    end
    if side == Ost
        coordinates = (coordinates[1], coordinates[2] + 1)
    end
    if side == West
        coordinates = (coordinates[1], coordinates[2] - 1)
    end
    return coordinates
end