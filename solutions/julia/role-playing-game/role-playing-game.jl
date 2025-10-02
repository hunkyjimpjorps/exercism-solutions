StringOrMissing = Union{String,Missing}
IntOrNothing = Union{Int,Nothing}

@kwdef mutable struct Player
    name::StringOrMissing = missing
    level::Int64 = 0
    health::Int64 = 100
    mana::IntOrNothing = nothing
end

function introduce(player::Player)
    coalesce(player.name, "Mighty Magician")
end

increment(_::Nothing) = 50
increment(mana::Int64) = mana + 100

increment(_::Missing) = "The Great"
increment(name::String) = "$name the Great"

function title!(player::Player)
    if player.level == 42
        player.name = increment(player.name)
    end
    player.name
end

function revive!(player::Player)
    if player.health == 0 
        player.health = 100
        player.mana = increment(player.mana)
    end
    player
end
