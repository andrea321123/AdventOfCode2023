module Day10

function visit(
    input::Vector{Vector{Char}},
    visited::Vector{Vector{Int}},
    i::Int,
    j::Int,
    dist::Int
)
    if (visited[i][j] != -1 && visited[i][j] <= dist) || input[i][j] == '.'
        return visited
    end
    visited[i][j] = dist

    pipe = input[i][j]
    if pipe == '|'
        visit(input, visited, i -1, j, dist +1)
        visit(input, visited, i +1, j, dist +1)
    elseif pipe == '-'
        visit(input, visited, i, j -1, dist +1)
        visit(input, visited, i, j +1, dist +1)
    elseif pipe == 'L'
        visit(input, visited, i -1, j, dist +1)
        visit(input, visited, i, j +1, dist +1)
    elseif pipe == 'J'
        visit(input, visited, i -1, j, dist +1)
        visit(input, visited, i, j -1, dist +1)
    elseif pipe == '7'
        visit(input, visited, i +1, j, dist +1)
        visit(input, visited, i, j -1, dist +1)
    elseif pipe == 'F'
        visit(input, visited, i +1, j, dist +1)
        visit(input, visited, i, j +1, dist +1)
    end

    visited
end

function day10(input::String)
    input = map(collect, split(input, "\n", keepempty=false))

    x, y = (1, 1)
    for i in 1:length(input)
        for j in 1:length(input[i])
            if input[i][j] == 'S'
                x, y = i, j
                break
            end
        end
    end
    input[x][y] = '-'

    visited = map(x -> map(y -> -1, 1:length(input[1])), 1:length(input))
    p1 = maximum(map(maximum, visit(input, visited, x, y, 0)))

    [string(p1), ""]
end

end # module Day10
