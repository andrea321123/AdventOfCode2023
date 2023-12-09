module Day09

using Chain

function solve(history::Vector{Int})
    sequences = [history]
    sequence = history
    while length(filter(x -> x != 0, sequence)) != 0
        sequence = @chain sequence begin
	    zip(_[1:(end -1)], _[2:end])
            map(x -> x[2] - x[1], _)
        end
        push!(sequences, sequence)
    end

    p1 = sum(map(last, sequences))
    p2 = foldr(-, map(first, sequences))
    return (p1, p2)
end

function day09(input::String)
    @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> map(y -> parse(Int, y), x), _)
	map(solve, _)
        [getindex.(_, i) for i in 1:length(first(_))]
        map(sum, _)
        map(string, _)
    end
end

end # module Day09
