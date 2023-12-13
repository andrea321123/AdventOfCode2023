module Day13

using Chain

function all_smudges(m::Vector{Vector{Char}}) ::Vector{Vector{Vector{Char}}}
    rows = length(m)
    cols = length(m[1])
    v = []

    for i in 1:rows
        for j in 1:cols
            m2 = deepcopy(m)
            m2[i][j] = m2[i][j] == '.' ? '#' : '.'
            push!(v, m2)
        end
    end
    v
end

function row_ref(m::Vector{Vector{Char}}, old::Int)
    for i in 1:(length(m) -1)
        if m[i] == m[(i +1)]
            up = i -1
            down = i +2
            valid = true
            while up > 0 && down <= length(m) && valid
                if m[up] != m[down]
                    valid = false
                    break
                end

                up -= 1
                down += 1
            end

            if valid && i != old
                return i
            end
        end
    end

    return 0
end

function day13(input::String)
    input = @chain input begin
        split("\n\n", keepempty=false)
        map(x -> split(x, "\n", keepempty=false), _)
        map(x -> map(collect, x), _)
    end

    result = []
    for i in 1:length(input)
        push!(result, [row_ref(input[i], 0), 'h'])
        if result[i][1] == 0
            rev = [getindex.(input[i], j) for j in 1:length(first(input[i]))]
            result[i] = [row_ref(rev, 0), 'v']
        end
    end

    result2 = @chain input begin
        map(all_smudges, _)
    end
    result2 = map(all_smudges, input)
    result3 = []
    for i in 1:length(result2)
        old = result[i][2] == 'h' ? result[i][1] : 0
        push!(result3, map(x -> row_ref(x, old), result2[i]))
    end
    result2 = @chain result3 begin
        map(x -> filter(y -> y != 0, x), _)
        map(x -> map(y -> [y, 'h'], x), _)
    end

    for i in 1:length(result2)
        if result2[i] == []
            result2[i] = @chain input[i] begin
                [getindex.(_, j) for j in 1:length(first(_))]
                all_smudges
                map(x -> row_ref(x, result[i][2] == 'v' ? result[i][1] : 0), _)
                filter(x -> x != 0, _)
                map(x -> [x, 'v'], _)
            end
        else
            result2[i] = [result2[i][1]]
        end
    end
    result2 = map(first, result2)

    p1 = sum(map(x -> x[1], filter(x -> x[2] == 'v', result)))
    p1 += 100sum(map(x -> x[1], filter(x -> x[2] == 'h', result)))
    p2 = sum(map(x -> x[1], filter(x -> x[2] == 'v', result2)))
    p2 += 100sum(map(x -> x[1], filter(x -> x[2] == 'h', result2)))
    [string(p1), string(p2)]
end

end # module Day13
