import gleam/regex
import gleam/string
import gleam/list

pub fn ciphertext(plaintext: String) -> String {
  let assert Ok(re) = regex.from_string("[^a-z0-9]")

  let cleaned_string =
    plaintext
    |> string.lowercase()
    |> regex.split(with: re)
    |> string.concat()

  let #(rows, columns) = determine_dimensions(string.length(cleaned_string), 0)

  cleaned_string
  |> string.pad_right(to: rows * columns, with: " ")
  |> string.to_graphemes()
  |> list.sized_chunk(into: columns)
  |> list.transpose()
  |> list.map(with: string.concat)
  |> string.join(with: " ")
}

fn determine_dimensions(length: Int, columns: Int) -> #(Int, Int) {
  case length, columns, columns * columns, columns * { columns - 1 } {
    n, c, _, rect if n <= rect -> #(c - 1, c)
    n, c, square, _ if n <= square -> #(c, c)
    n, c, _, _ -> determine_dimensions(n, c + 1)
  }
}
