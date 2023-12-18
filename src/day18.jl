module Day18

using Chain

function area(p::Vector{Vector{Int}})
    a = 0
    for i in 1:(length(p) -1)
        a += (p[i][1] * p[(i +1)][2]) - (p[(i +1)][1] * p[i][2])
    end
    abs(a) /2
end

function solve(input::Vector{Vector{Any}})
    curr = [1, 1]
    vertices = [curr]
    perimeter = 0

    for i in input
        if i[1] == "U"
            curr = [(curr[1] - i[2]), curr[2]]
        elseif i[1] == "D"
            curr = [(curr[1] + i[2]), curr[2]]
        elseif i[1] == "L"
            curr = [curr[1], (curr[2] - i[2])]
        elseif i[1] == "R"
            curr = [curr[1], (curr[2] + i[2])]
        end
        push!(vertices, curr)
        perimeter += i[2]
    end

    i = area(vertices) - (perimeter /2) +1
    floor(Int, i + perimeter)
end

function day18(input::String)
    input = @chain input begin
        replace("(#" => "")
        replace(")" => "")
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> [x[1], parse(Int, x[2]), x[3]], _)
    end
    p1 = solve(input)

    direction_map = Dict('0' => "R", '1' => "D", '2' => "L", '3' => "U")
    input = @chain input begin
        map(last, _)
        map(x -> [direction_map[x[6]], parse(Int, x[1:5], base=16)], _)
    end
    p2 = solve(input)

    [string(p1), string(p2)]
end

end # module Day18
