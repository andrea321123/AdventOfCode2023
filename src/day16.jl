module Day16

function step_rec(
    input::Vector{Vector{Char}},
    out::Vector{Vector{Char}},
    memo::Set{Tuple{Int, Int, Char}},
    i::Int,
    j::Int,
    dir::Char
)
    if i <= 0 || j <= 0 || i > length(input) || j > length(input[1])
        return out
    end

    if (i, j, dir) ∈ memo
        return out
    end
    push!(memo, (i, j, dir))
    out[i][j] = '#'

    new_i = i
    new_j = j
    if dir == 'N'
        new_i -= 1
    elseif dir == 'S'
        new_i += 1
    elseif dir == 'W'
        new_j -= 1
    elseif dir == 'E'
        new_j += 1
    end

    if input[i][j] == '-'
        if dir == 'N' || dir == 'S'
            step_rec(input, out, memo, i, j -1, 'W')
            step_rec(input, out, memo, i, j +1, 'E')
        else
            step_rec(input, out, memo, new_i, new_j, dir)
        end
    elseif input[i][j] == '|'
        if dir == 'E' || dir == 'W'
            step_rec(input, out, memo, i -1, j, 'N')
            step_rec(input, out, memo, i +1, j, 'S')
        else
            step_rec(input, out, memo, new_i, new_j, dir)
        end
    elseif input[i][j] == '/'
        if dir == 'N'
            step_rec(input, out, memo, i, j +1, 'E')
        elseif dir == 'S'
            step_rec(input, out, memo, i, j -1, 'W')
        elseif dir == 'W'
            step_rec(input, out, memo, i +1, j, 'S')
        elseif dir == 'E'
            step_rec(input, out, memo, i -1, j, 'N')
        end
    elseif input[i][j] == '\\'
        if dir == 'N'
            step_rec(input, out, memo, i, j -1, 'W')
        elseif dir == 'S'
            step_rec(input, out, memo, i, j +1, 'E')
        elseif dir == 'W'
            step_rec(input, out, memo, i -1, j, 'N')
        elseif dir == 'E'
            step_rec(input, out, memo, i +1, j, 'S')
        end
    else
        step_rec(input, out, memo, new_i, new_j, dir)
    end

    out
end

function step(input::Vector{Vector{Char}}, i::Int, j::Int, dir::Char)
    out = map(x -> map(y -> '.', x), input)
    step_rec(input, out, Set{Tuple{Int, Int, Char}}(), i, j, dir)
end

energized(out::Vector{Vector{Char}}) =
    sum(map(x -> length(filter(y -> y == '#', x)), out))

function day16(input::String)
    input = map(collect, split(input, "\n", keepempty=false))

    p1 = energized(step(input, 1, 1, 'E'))

    possibilities = []
    for i in 1:length(input)
        push!(possibilities, energized(step(input, i, 1, 'E')))
        push!(possibilities, energized(step(input, i, length(input[i]), 'W')))
    end
    for j in 1:length(input)
        push!(possibilities, energized(step(input, 1, j, 'S')))
        push!(possibilities, energized(step(input, length(input), j, 'N')))
    end
    p2 = maximum(possibilities)

    [string(p1), string(p2)]
end

end # module Day16
