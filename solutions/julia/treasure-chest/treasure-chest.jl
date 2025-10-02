struct TreasureChest{T}
  password::String
  treasure::T
end

function get_treasure(password_attempt, chest)
  chest.password == password_attempt ? chest.treasure : nothing
end

function multiply_treasure(multiplier, chest)
  TreasureChest(chest.password, fill(chest.treasure, multiplier))
end
