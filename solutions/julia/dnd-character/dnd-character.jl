using Pipe

function modifier(ability)
    floor((ability - 10) / 2)
end

function ability()
    @pipe rand(1:6, 4) |> sort |> _[2:4] |> sum
end

mutable struct DNDCharacter
    strength::Int
    dexterity::Int
    constitution::Int
    intelligence::Int
    wisdom::Int
    charisma::Int
    hitpoints::Int
    
    function DNDCharacter()
        con = ability()
        new(ability(), ability(), con, ability(), ability(), ability(), 10 + modifier(con))
    end
end


