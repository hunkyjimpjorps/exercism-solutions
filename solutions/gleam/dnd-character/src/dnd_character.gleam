import gleam/int
import gleam/iterator
import gleam/list

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let con = ability()

  Character(
    charisma: ability(),
    constitution: con,
    dexterity: ability(),
    hitpoints: 10 + modifier(con),
    intelligence: ability(),
    strength: ability(),
    wisdom: ability(),
  )
}

pub fn modifier(score: Int) -> Int {
  case score {
    s if s >= 10 -> { s - 10 } / 2
    s -> { s - 11 } / 2
  }
}

pub fn ability() -> Int {
  iterator.repeatedly(fn() { int.random(1, 6) })
  |> iterator.take(4)
  |> iterator.to_list()
  |> list.sort(int.compare)
  |> list.drop(1)
  |> int.sum()
}
