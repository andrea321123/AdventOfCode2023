module AdventOfCode2023

using Printf

function readInput(day::Integer)
    path = joinpath(@__DIR__, "..", "input", @sprintf("day%02d.txt", day))
    input = open(path, "r") do file
        read(file, String)
    end
    return input
end
export readInput

# Include source files.
files = readdir(@__DIR__)
files = filter(x -> startswith(x, "day"), files)
for file in files
    include(joinpath(@__DIR__, file))
end

end # module AdventOfCode2023
