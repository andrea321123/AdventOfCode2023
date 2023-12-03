module Day03

using Chain

function day03(input::String)
    input = split(input, "\n", keepempty=false)
    numbers = []
    n = length(input)

    for i in 1:n
        j = 1
        while j <= n
            if isdigit(input[i][j])
                left = j
                j += 1
                while j <= n && isdigit(input[i][j])
                    j += 1
                end
                j -= 1
                push!(numbers, [i, left, j, 0])
            end
            j += 1
        end
    end

    p1 = 0
    p2 = []
    for i in 1:n
        for j in 1:n
            if !isdigit(input[i][j]) && input[i][j] != '.'
                for z in numbers
                    z1, z2, z3, z4 = z
                    if z1 -1 <= i <= z1 +1 && z2 -1 <= j <= z3 +1 && z4 == 0
                        z4 = 1
                        p1 += parse(Int, input[z1][z2:z3])
                    end
                end
            end
            if input[i][j] == '*'
                parts = Vector{Int}()
                for z in numbers
                    z1, z2, z3 = z
                    if z1 -1 <= i <= z1 +1 && z2 -1 <= j <= z3 +1
                        push!(parts, parse(Int, input[z1][z2:z3]))
                    end
                end
                push!(p2, parts)
            end
        end
    end

    p2 = @chain p2 begin
        filter(x -> length(x) == 2, _)
        map(prod, _)
        sum
    end

    [string(p1), string(p2)]
end

end # module Day03
