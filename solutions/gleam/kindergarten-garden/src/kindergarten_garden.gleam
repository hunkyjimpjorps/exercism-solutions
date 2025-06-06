import gleam/string
import gleam/list
import gleam/result

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  diagram
  |> string.split("\n")
  |> list.map(fn(str) {
    str
    |> string.to_graphemes()
    |> list.sized_chunk(2)
  })
  |> list.transpose()
  |> list.map(fn(strs) {
    strs
    |> list.flatten()
    |> list.map(to_plant)
  })
  |> list.zip(roster, _)
  |> list.key_find(student)
  |> result.unwrap([])
}

const roster = [
  Alice,
  Bob,
  Charlie,
  David,
  Eve,
  Fred,
  Ginny,
  Harriet,
  Ileana,
  Joseph,
  Kincaid,
  Larry,
]

fn to_plant(str: String) -> Plant {
  case str {
    "R" -> Radishes
    "C" -> Clover
    "V" -> Violets
    "G" -> Grass
    _ -> panic
  }
}
