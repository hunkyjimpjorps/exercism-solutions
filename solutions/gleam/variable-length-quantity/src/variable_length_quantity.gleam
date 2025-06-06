import gleam/list
import gleam/int

pub type Error {
  IncompleteSequence
}

pub fn encode(integers: List(Int)) -> BitArray {
  list.fold(
    integers,
    <<>>,
    fn(acc, i) {
      case i {
        0 -> <<acc:bits, 0>>
        next -> <<acc:bits, encode_one(next, 0, <<>>):bits>>
      }
    },
  )
}

fn encode_one(i: Int, sign_bit: Int, acc: BitArray) -> BitArray {
  case i {
    0 -> acc
    next ->
      int.bitwise_shift_right(next, 7)
      |> encode_one(1, <<sign_bit:1, next:7, acc:bits>>)
  }
}

pub fn decode(string: BitArray) -> Result(List(Int), Error) {
  do_decode(string, 0, [])
}

fn do_decode(
  string: BitArray,
  register: Int,
  acc: List(Int),
) -> Result(List(Int), Error) {
  case string {
    <<>> -> Ok(list.reverse(acc))
    <<1:1, _:7>> -> Error(IncompleteSequence)
    <<0:1, next:7, rest:bits>> ->
      [int.bitwise_or(next, int.bitwise_shift_left(register, 7)), ..acc]
      |> do_decode(rest, 0, _)
    <<1:1, next:7, rest:bits>> ->
      int.bitwise_or(next, int.bitwise_shift_left(register, 7))
      |> do_decode(rest, _, acc)
  }
}
