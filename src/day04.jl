module Day04

using Chain

function day04(input::String)
    n = 10
    input = @chain input begin
        replace(r"Card\s+\d+:" => "")
        replace(" | " => " ")
        split("\n", keepempty=false)
        map(x -> split(x, " ", keepempty=false), _)
        map(x -> map(y -> parse(Int, y), x), _)
        map(x -> [x[1:n], x[(n +1):end]], _)
        map(x -> [Set(x[1]), Set(x[2])], _)
        map(x -> intersect(x[1], x[2]), _)
        map(length, _)
    end

    p1 = @chain input begin
        filter(x -> x != 0, _)
        map(x -> 2^(x - 1), _)
        sum
    end

    scratchcards = map(x -> 1, range(1, length(input)))
    for i in 1:length(input)
        for j in (i +1):(i + input[i])
            scratchcards[j] += scratchcards[i]
        end
    end
    p2 = sum(scratchcards)

    [string(p1), string(p2)]
end

end # module Day04
