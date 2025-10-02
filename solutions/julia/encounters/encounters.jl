abstract type Pet end

struct Dog <: Pet
    name::String
end

struct Cat <: Pet
    name::String
end

name(p::Pet) = p.name

meets(_::Dog, _::Dog) = "sniffs"
meets(_::Dog, _::Cat) = "chases"
meets(_::Cat, _::Dog) = "hisses"
meets(_::Cat, _::Cat) = "slinks"
meets(_::Pet, _::Pet) = "is cautious"
meets(_::Pet, _::Any) = "runs away"
meets(_::Any, _::Any) = "nothing happens"

encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."
