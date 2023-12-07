module Day07

using Chain
using StatsBase

function parse_input(input::String)
    @chain input begin
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        sort
        reverse
        map(x -> [x[1], parse(Int, x[2])], _)
        map(x -> [countmap(x[1]), x[2]], _)
    end
end

function parse_hand(hand::Dict{Char, Int}, jokers::Int)
    @chain hand begin
        replace(kv -> kv[1] => kv[1] == '0' ? 0 : kv[2], _)
        values
        collect
        sort
        reverse
        [_[1] + jokers; _[2:end]]
    end
end

function solve(input::Vector{Vector{Any}})
    five = filter(x -> 5 ∈ x[1], input)
    four = filter(x -> 4 ∈ x[1], input)
    full = filter(x -> 3 ∈ x[1] && 2 ∈ x[1], input)
    three = filter(x -> 3 ∈ x[1] && 2 ∉ x[1], input)
    double = filter(x -> count(==(2), x[1]) == 2, input)
    pair = filter(x -> count(==(2), x[1]) == 1 && 3 ∉ x[1], input)
    high = filter(x -> maximum(x[1]) == 1, input)

    @chain [five; four; full; three; double; pair; high] begin
        reverse
	map(x -> x[2], _)
        zip(_, range(1, length(_)))
        map(x -> x[1] * x[2], _)
        sum
    end
end

function day07(input::String)
    input = @chain input begin
        replace("A" => "E")
        replace("K" => "D")
        replace("Q" => "C")
        replace("J" => "B")
        replace("T" => "A")
    end

    input1 = @chain input begin
        parse_input
        map(x -> [values(x[1]), x[2]], _)
    end

    input2 = @chain input begin
        replace("B" => "0")
        parse_input
        map(x -> [x[1], x[2], '0' in keys(x[1]) ? x[1]['0'] : 0], _)
        map(x -> [parse_hand(x[1], x[3]), x[2], x[3]], _)
    end

    [string(solve(input1)), string(solve(input2))]
end

end # module Day07
