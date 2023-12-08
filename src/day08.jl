module Day08

using Chain

function day08(input::String)
    input = @chain input begin
        replace("= (" => "")
        replace("," => "")
        replace(")" => "")
        split("\n\n", keepempty=false)
        @aside seq = _[1]
        _[2]
        split("\n", keepempty=false)
        map(x -> split(x, " "), _)
        map(x -> [string(x[1]), [string(x[2]), string(x[3])]], _)
        Dict
    end

    p1 = 0
    element = "AAA"
    i = 1
    while element != "ZZZ"
        element = seq[i] == 'L' ? input[element][1] : input[element][2]

        p1 += 1
        i = i == length(seq) ? 1 : i +1
    end

    steps = 0
    elements = collect(filter(x -> x[3] == 'A', keys(input)))
    i = 1
    cycles = zeros(Int, length(elements))
    while true
        elements = map(x -> seq[i] == 'L' ? input[x][1] : input[x][2], elements)

        for i in 1:length(elements)
            if elements[i][3] == 'Z'
                cycles[i] = steps +1
            end
        end
        if length(filter(x -> x == 0, cycles)) == 0
            break
        end

        steps += 1
        i = i == length(seq) ? 1 : i +1
    end

    [string(p1), string(reduce(lcm, cycles))]
end

end # module Day08
