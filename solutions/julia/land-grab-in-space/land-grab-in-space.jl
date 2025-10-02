struct Coord
  x::UInt16
  y::UInt16
end

@kwdef struct Plot
  bottom_left::Coord
  top_right::Coord
end

function is_claim_staked(claim::Plot, register::Set{Plot})
  claim ∈ register
end

function stake_claim!(claim::Plot, register::Set{Plot})
  if is_claim_staked(claim, register)
    false
  else
    push!(register, claim)
    true
  end
end

function get_longest_side(claim::Plot)
  max(claim.top_right.x - claim.bottom_left.x, claim.top_right.y - claim.bottom_left.y)
end

function get_claim_with_longest_side(register::Set{Plot})
  longest_side = maximum(get_longest_side.(register))

  Set([p for p = register if get_longest_side(p) == longest_side])
end
