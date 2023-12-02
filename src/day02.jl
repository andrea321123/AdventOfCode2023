module Day02

using Chain

function maxc(v::Vector{Vector{Any}}, c::String)
    maximum(filter(x -> x[2] == c, v))[1]
end

function day02(input::String)
    input = @chain input begin
	replace("Game " => "")
	replace(": " => ":")
	replace(", " => ",")
	replace("; " => ";")
	replace(";" => ",")
	replace("red" => "r")
	replace("green" => "g")
	replace("blue" => "b")
        split("\n", keepempty=false)
        map(x -> split(x, ":"), _)
        map(x -> [parse(Int, x[1]), split(x[2], ",")], _)
        map(x -> [x[1], map(split, x[2])], _)
        map(x -> [x[1], map(y -> [parse(Int, y[1]), y[2]], x[2])], _)
        map(x -> [x[1], maxc(x[2], "r"), maxc(x[2], "g"), maxc(x[2], "b")],  _)
    end

    p1 = @chain input begin
        filter(x -> x[2] < 13 && x[3] < 14 && x[4] < 15, _)
        map(x -> x[1], _)
        sum
    end

    p2 = @chain input begin
        map(x -> x[2:end], _)
        map(prod, _)
        sum
    end

    [string(p1), string(p2)]
end

end # module Day02
