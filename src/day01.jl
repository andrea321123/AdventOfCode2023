module Day01

using Chain

function convert(string::SubString{String})
    @chain string begin
        filter(isdigit, _)
        _[1] * _[end]
        parse(Int, _)
    end
end

function day01(input::String)
    input = split(input, "\n", keepempty=false)

    p1 = @chain input begin
        map(convert, _)
        sum
    end

    p2 = @chain input begin
        replace("one" => "o1e")
        replace("two" => "t2o")
        replace("three" => "t3e")
        replace("four" => "f4r")
        replace("five" => "f5e")
        replace("six" => "s6x")
        replace("seven" => "s7n")
        replace("eight" => "e8t")
        replace("nine" => "n9e")
        map(convert, _)
        sum
    end

    return [string(p1), string(p2)]
end

end # module Day01
