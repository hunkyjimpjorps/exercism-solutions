import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
  Reverse
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let assert Ok(bits) = int.digits(encoded_message, 2)

  list.zip(
    list.reverse(bits),
    [Wink, DoubleBlink, CloseYourEyes, Jump, Reverse],
  )
  |> list.filter_map(fn(p) {
    let #(bit, com) = p
    case bit {
      1 -> Ok(com)
      0 -> Error(Nil)
    }
  })
  |> fn(commands) {
    case list.reverse(commands) {
      [Reverse, ..rest] -> rest
      _ -> commands
    }
  }
}
