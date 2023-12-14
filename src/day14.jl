module Day14

function tilt(m::Vector{Vector{Char}}, dir::Char)
    l = length(m)
    if dir == 'N'
        for i in 1:l
            for j in 1:l
                if m[i][j] == 'O'
                    h = i - 1
                    while h > 0 && m[h][j] == '.'
                        h -= 1
                    end
                    h += 1
                    m[i][j] = '.'
                    m[h][j] = 'O'
                end
            end
        end
    elseif dir == 'S'
        for i in reverse(1:l)
            for j in reverse(1:l)
                if m[i][j] == 'O'
                    h = i + 1
                    while h <= l && m[h][j] == '.'
                        h += 1
                    end
                    h -= 1
                    m[i][j] = '.'
                    m[h][j] = 'O'
                end
            end
        end
    elseif dir == 'W'
        for j in 1:l
            for i in 1:l
                if m[i][j] == 'O'
                    k = j - 1
                    while k > 0 && m[i][k] == '.'
                        k -= 1
                    end
                    k += 1
                    m[i][j] = '.'
                    m[i][k] = 'O'
                end
            end
        end
    elseif dir == 'E'
        for j in reverse(1:l)
            for i in reverse(1:l)
                if m[i][j] == 'O'
                    k = j + 1
                    while k <= l && m[i][k] == '.'
                        k += 1
                    end
                    k -= 1
                    m[i][j] = '.'
                    m[i][k] = 'O'
                end
            end
        end
    end
end

function load(m::Vector{Vector{Char}})
    load = 0
    l = length(m)
    for i in 1:l
        for j in 1:l
            if m[i][j] == 'O'
                load += l - i +1
            end
        end
    end
    load
end

function day14(input::String)
    input = map(collect, split(input, "\n", keepempty=false))

    input1 = deepcopy(input)
    tilt(input1, 'N')
    p1 = load(input1)

    N = 1000000000
    memo_set = Set()
    memo_map = Dict()
    period = 1
    i = 1
    while i <= N
        tilt(input, 'N')
        tilt(input, 'W')
        tilt(input, 'S')
        tilt(input, 'E')

        if  period == 1 && input ∈ memo_set
            period = i - memo_map[input]
            i += floor(Int, (N - i) / period) * period
        end

        input_copy = deepcopy(input)
        push!(memo_set, input_copy)
        push!(memo_map, input_copy => i)

        i += 1
    end
    p2 = load(input)

    [string(p1), string(p2)]
end

end # module Day14
