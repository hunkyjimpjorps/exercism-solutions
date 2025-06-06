import gleam/int
import gleam/float
import gleam/list
import gleam/dict.{type Dict}

const book_price = 800.0

fn pack_price(count: Int) -> Float {
  case count {
    1 -> 1.0
    2 -> 0.95
    3 -> 0.9
    4 -> 0.8
    _ -> 0.75 // 5
  } *. book_price *. int.to_float(count)
}

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> frequencies()
  |> make_packs([])
  |> list.map(pack_price)
  |> float.sum()
}

// A greedy algorithm works for most of these test cases, except for the case in the example
// where two four-book packs are cheaper than a three-book pack and a five-book pack
// Therefore, just use a greedy algorithm and then manually replace any pairs of three-
// and five-book packs with two four-book packs

fn make_packs(basket: Dict(Int, Int), acc: List(Int)) -> List(Int) {
  case dict.size(basket) {
    0 -> {
      case list.contains(acc, 3) && list.contains(acc, 5) {
        True -> make_packs(basket, replace(acc))
        False -> acc
      }
    }
    _ -> {
      let data =
        dict.filter(basket, fn(_, v) { v != 0 })
        |> dict.map_values(fn(_, v) { v - 1 })
      case dict.size(data) {
        0 -> acc
        n -> [n, ..acc]
      }
      |> make_packs(data, _)
    }
  }
}

fn frequencies(xs: List(a)) -> Dict(a, Int) {
  xs
  |> list.group(by: fn(x) { x })
  |> dict.map_values(fn(_, v) { list.length(v) })
}

fn replace(xs: List(Int)) -> List(Int) {
  let assert Ok(#(_, xs)) = list.pop(xs, fn(x) { x == 3 })
  let assert Ok(#(_, xs)) = list.pop(xs, fn(x) { x == 5 })
  [4, 4, ..xs]
}
