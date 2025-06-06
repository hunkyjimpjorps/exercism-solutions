import gleam/string
import gleam/list

pub fn first_letter(name: String) -> String {
  let assert Ok(initial) =
    name
    |> string.trim()
    |> string.first()
  initial
}

pub fn initial(name: String) -> String {
  name
  |> first_letter()
  |> string.uppercase()
  |> string.append(suffix: ".")
}

pub fn initials(full_name: String) -> String {
  full_name
  |> string.split(on: " ")
  |> list.map(initial)
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials(
    full_name1,
  ) <> "  +  " <> initials(full_name2) <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
