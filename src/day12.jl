module Day12

using Chain

function all(s::Vector{Char}, i::Int, len::Int, l::Vector{Vector{Char}})
    if i > len
        return [s]
    end
    if s[i] != '?'
        return all(s, i +1, len, l)
    end

    s = copy(s)
    s[i] = '#'
    l1 = []
    append!(l1, all(s, i +1, len, l))
    s = copy(s)
    s[i] = '.'
    append!(l1, all(s, i +1, len, l))
    l1
end

function solve(input::Vector{Vector})
    @chain input begin
	all(_[1], 1, length(_[1]), Vector{Vector{Char}}())
	map(String, _)
        map(x -> split(x, ".", keepempty=false), _)
        map(x -> map(length, x), _)
        filter(x -> x == input[2], _)
        length
    end
end

function day12(input::String)
    input = @chain input begin
	split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> [collect(x[1]), split(x[2], ",")], _)
        map(x -> [x[1], map(y -> parse(Int, y), x[2])], _)
    end

    p1 = @chain input begin
        map(solve, _)
        sum
        string
    end

    [p1, ""]
end

end # module Day12
