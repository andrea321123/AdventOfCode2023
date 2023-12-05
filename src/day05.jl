module Day05

using Chain

function solve(S::Set{Vector{Int}}, input::Vector{Vector{Vector{Int}}})
    for L in input
        new_S = Set()
        for s in S
            for l in L
                if s[1] > s[2]
                    break
                end
                if s[2] < l[1]
                    push!(new_S, s)
                    break
                end
                if s[1] > l[2]
                    continue
                end

                new_range = [s[1], (l[1] - 1)]
                if l[1] > s[1]
                    push!(new_S, new_range)
                    s[1] = l[1]
                end

                offset = l[3] - l[1]
                new_range = [s[1], min(l[2], s[2])]
                s[1] = new_range[2] + 1
                new_range = new_range .+ offset
                push!(new_S, new_range)
            end
            if s[1] <= s[2]
                push!(new_S, s)
            end
        end
        S = new_S
    end
    return minimum(map(x -> x[1], collect(S)))
end

function day05(input::String)
    input = @chain input begin
        replace("seeds: " => "seeds:\n")
        split("\n\n", keepempty=false)
        map(x -> split(x, "\n", keepempty=false), _)
        map(x -> x[2:end], _)
        map(x -> map(y -> split(y, " ", keepempty=false), x), _)
        map(x -> map(y -> map(z -> parse(Int, z), y), x), _)
        @aside seeds = _[1][1]
        _[2:end]
        map(x -> map(y -> [y[2], (y[3] + y[2] -1), y[1]], x), _)
        map(sort, _)
    end

    seeds1 = @chain seeds begin
	map(x -> [x, x], _)
        Set
    end

    seeds2 = @chain seeds begin
	map(collect, Iterators.partition(_, 2))
        map(x -> [x[1], (x[1] + x[2] -1)], _)
        Set
    end

    [string(solve(seeds1, input)), string(solve(seeds2, input))]
end

end # module Day05
