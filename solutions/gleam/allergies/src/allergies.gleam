import gleam/int
import gleam/list

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

fn allergen_bit(allergen: Allergen) {
  case allergen {
    Eggs -> 0b0000_0001
    Peanuts -> 0b0000_0010
    Shellfish -> 0b0000_0100
    Strawberries -> 0b0000_1000
    Tomatoes -> 0b0001_0000
    Chocolate -> 0b0010_0000
    Pollen -> 0b0100_0000
    Cats -> 0b1000_0000
  }
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  int.bitwise_and(allergen_bit(allergen), score) != 0
}

pub fn list(score: Int) -> List(Allergen) {
  [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]
  |> list.filter(allergic_to(_, score))
}
