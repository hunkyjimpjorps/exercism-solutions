import gleam/bool
import gleam/list
import gleam/result
import gleam/string

pub fn build(letter: String) -> String {
  let assert [n] = string.to_utf_codepoints(letter)
  let max = string.utf_codepoint_to_int(n) - 64

  let letters = letter_range(letter)
  let [_, ..rest_of_letters] = list.reverse(letters)

  let all_letters = list.append(letters, rest_of_letters)
  list.append(
    list.range(max - 1, 0),
    bool.guard(max == 1, [], fn() { list.range(1, max - 1) }),
  )
  |> list.zip(all_letters)
  |> list.map(make_line(_, 2 * max - 1))
  |> string.join("\n")
}

fn letter_range(last_letter: String) -> List(String) {
  let assert [from, to] = string.to_utf_codepoints("A" <> last_letter)
  list.range(string.utf_codepoint_to_int(from), string.utf_codepoint_to_int(to))
  |> list.try_map(string.utf_codepoint)
  |> result.unwrap([])
  |> string.from_utf_codepoints()
  |> string.to_graphemes()
}

fn make_line(pair: #(Int, String), max_length: Int) -> String {
  case pair {
    #(spaces, "A" as letter) ->
      string.concat([
        string.repeat(" ", spaces),
        letter,
        string.repeat(" ", spaces),
      ])
    #(spaces, letter) ->
      string.concat([
        string.repeat(" ", spaces),
        letter,
        string.repeat(" ", max_length - 2 * spaces - 2),
        letter,
        string.repeat(" ", spaces),
      ])
  }
}
