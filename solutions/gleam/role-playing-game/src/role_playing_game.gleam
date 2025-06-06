import gleam/option.{None, type Option, Some}
import gleam/int

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health, player.level {
    0, lv if lv >= 10 -> Some(Player(..player, health: 100, mana: Some(100)))
    0, _ -> Some(Player(..player, health: 100, mana: None))
    _, _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana, cost {
    Some(m), c if c <= m -> #(Player(..player, mana: Some(m - c)), 2 * c)
    Some(_), _ -> #(player, 0)
    None, c -> #(Player(..player, health: int.max(0, player.health - c)), 0)
  }
}
