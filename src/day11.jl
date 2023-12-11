module Day11

using Chain
using Combinatorics
using SplitApplyCombine

function distance(
    a::Tuple{Int, Int},
    b::Tuple{Int, Int},
    rows::Set{Int},
    columns::Set{Int},
    mult::Int
)
    dist = 0
    for i in (min(a[1], b[1]) +1):(max(a[1], b[1]))
        dist += i ∈ rows ? mult : 1
    end

    for j in (min(a[2], b[2]) +1):(max(a[2], b[2]))
        dist += j ∈ columns ? mult : 1
    end
    dist
end

function day11(input::String)
    input = @chain input begin
        split("\n", keepempty=false)
        map(collect, _)
    end

    invert_input = invert(input)
    empty_rows = Set(filter(x -> '#' ∉ input[x], 1:length(input)))
    empty_cols = Set(filter(x -> '#' ∉ invert_input[x], 1:length(input)))

    galaxies = []
    for i in 1:length(input)
        for j in 1:length(input[1])
            if input[i][j] == '#'
                push!(galaxies, (i, j))
            end
        end
    end


    comb = collect(combinations(galaxies, 2))
    p1 = sum(map(x -> distance(x[1], x[2], empty_rows, empty_cols, 2), comb))
    p2 = sum(map(x -> distance(x[1], x[2], empty_rows, empty_cols, 1000000), comb))
    [string(p1), string(p2)]
end

end # module Day11
