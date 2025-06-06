import gleam/map.{Map}
import gleam/list
import gleam/string
import gleam/option.{None, Some}

pub fn nucleotide_count(dna: String) -> Result(Map(String, Int), Nil) {
  let start =
    "ACGT"
    |> string.to_graphemes()
    |> list.map(fn(c) { #(c, 0) })
    |> map.from_list()

  list.try_fold(
    over: string.to_graphemes(dna),
    from: start,
    with: add_nucleotide,
  )
}

fn add_nucleotide(acc, c) {
  case c {
    "A" | "C" | "G" | "T" -> Ok(map.update(acc, c, increment))
    _ -> Error(Nil)
  }
}

fn increment(i) {
  case i {
    Some(i) -> i + 1
    None -> 1
  }
}
