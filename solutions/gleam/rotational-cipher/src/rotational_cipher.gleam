import gleam/string
import gleam/list
import gleam/map
import gleam/result

pub fn rotate(shift_key: Int, text: String) -> String {
  let cipher = make_cipher(shift_key)

  text
  |> string.to_graphemes()
  |> list.map(fn(c) {
    case map.get(cipher, c) {
      Ok(c_new) -> c_new
      Error(Nil) -> c
    }
  })
  |> string.concat()
}

fn make_cipher(shift_key: Int) -> map.Map(String, String) {
  let [from, to] =
    string.to_utf_codepoints("az")
    |> list.map(string.utf_codepoint_to_int)

  let alphabet =
    list.range(from, to)
    |> list.map(string.utf_codepoint)
    |> result.values()
    |> string.from_utf_codepoints()
    |> string.to_graphemes()

  let #(head, tail) = list.split(alphabet, shift_key)

  list.append(tail, head)
  |> list.zip(alphabet, _)
  |> list.flat_map(fn(tup) {
    let #(k, v) = tup
    [#(k, v), #(string.uppercase(k), string.uppercase(v))]
  })
  |> map.from_list()
}
