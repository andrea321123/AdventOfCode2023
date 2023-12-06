module Day06

using Chain

function solve(v::Tuple{Int, Int})
    t, r = v
    x1 = (t - sqrt(t^2 - 4r)) /2
    x2 = (t + sqrt(t^2 - 4r)) /2
    x1 = ceil(x1) == x1 ? ceil(Int, x1 +1) : ceil(Int, x1)
    x2 = floor(x2) == x2 ? floor(Int, x2 -1) : floor(Int, x2)
    x2 - x1 + 1
end

function day06(input::String)
    input = @chain input begin
	replace(r".+:" => "")
	replace(r" +" => " ")
        split("\n", keepempty=false)
    end

    input1 = @chain input begin
        map(x -> split(x, " ", keepempty=false), _)
        map(x -> map(y -> parse(Int, y), x), _)
        zip(_[1], _[2])
    end

    input2 = @chain input begin
	map(x -> replace(x, " " => ""), _)
        map(x -> parse(Int, x), _)
        [(_[1], _[2])]
    end

    p1 = reduce(*, map(solve, input1))
    p2 = reduce(*, map(solve, input2))
    [string(p1), string(p2)]
end

end # module Day06
