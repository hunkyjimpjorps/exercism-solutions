import gleam/string
import gleam/list
import gleam/result

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  let pairs =
    list.strict_zip(string.to_graphemes(strand1), string.to_graphemes(strand2))

  {
    use pair <- result.map(pairs)
    use #(a, b) <- list.filter(pair)
    a != b
  }
  |> result.map(list.length(_))
  |> result.replace_error(Nil)
}
