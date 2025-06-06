using Pipe:@pipe

letterscores = [(['A' 'E' 'I' 'O' 'U' 'L' 'N' 'R' 'S' 'T'], 1)
                (['D' 'G'], 2)
                (['B' 'C' 'M' 'P'], 3)
                (['F' 'H' 'V' 'W' 'Y'], 4)
                (['K'], 5)
                (['J', 'X'], 8)
                (['Q', 'Z'], 10)];

letterdict = Dict{Char,Int}()

for category in letterscores
    value = category[2]
    for letter in category[1]
        letterdict[letter] = value
    end
end

function score(str)
    if str == "" return 0 end 
    @pipe str |>
        uppercase |>
        replace(_, r"[^A-Z]" => "") |>
        collect |>
        map(c -> letterdict[c], _) |>
        sum        
end
