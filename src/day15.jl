module Day15

using Chain

function hash(s::String)
    h = 0
    for c in s
        h += Int(c)
        h *= 17
        h %= 256
    end
    h
end

function day15(input::String)
    input = @chain input begin
        replace("\n" => "")
	split(",", keepempty=false)
        map(string, _)
    end

    p1 = sum(map(hash, input))

    boxes = map(x -> Dict(), 1:length(input))
    boxes_l = map(x ->[], 1:length(input))
    for s in input
        if s[end] == '-'
            str = String(s[1:(end -1)])
            i = hash(str) +1

            if s[1:(end -1)] ∈ keys(boxes[i])
                delete!(boxes[i], str)
                boxes_l[i] = filter(x -> x[1] != str, boxes_l[i])
            end
        else
            s = split(s, "=")
            str = String(s[1])
            n = parse(Int, s[2])
            i = hash(str) +1
            if str ∈ keys(boxes[i])
                boxes_l[i] = map(x -> x[1] != str ? x : [x[1], n], boxes_l[i])
            else
                push!(boxes_l[i], [str, n])
            end
            push!(boxes[i], str => n)
        end
    end

    p2 = 0
    for i in 1:length(boxes_l)
        for j in 1:length(boxes_l[i])
            p2 += i * j * boxes_l[i][j][2]
        end
    end

    [string(p1), string(p2)]
end

end # module Day15
