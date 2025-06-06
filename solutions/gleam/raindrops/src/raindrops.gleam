import gleam/list
import gleam/int
import gleam/string

pub fn convert(number: Int) -> String {
  let factor_pairs = [#(3, "Pling"), #(5, "Plang"), #(7, "Plong")]

  list.filter_map(
    factor_pairs,
    fn(p) {
      let #(div, sound) = p
      case number % div == 0 {
        True -> Ok(sound)
        False -> Error(Nil)
      }
    },
  )
  |> fn(strs) {
    case strs {
      [_, ..] -> string.concat(strs)
      [] -> int.to_string(number)
    }
  }
}