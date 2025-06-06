const to_roman: List(#(Int, String)) = [
  #(1000, "M"),
  #(900, "CM"),
  #(500, "D"),
  #(400, "CD"),
  #(100, "C"),
  #(90, "XC"),
  #(50, "L"),
  #(40, "XL"),
  #(10, "X"),
  #(9, "IX"),
  #(5, "V"),
  #(4, "IV"),
  #(1, "I"),
]

pub fn convert(number: Int) -> String {
  next_symbol(to_roman, number, "")
}

fn next_symbol(table: List(#(Int, String)), n: Int, acc: String) {
  case table {
    [] -> acc
    [#(val, sym), ..rest] -> {
      case n >= val {
        True -> next_symbol(table, n - val, acc <> sym)
        False -> next_symbol(rest, n, acc)
      }
    }
  }
}
