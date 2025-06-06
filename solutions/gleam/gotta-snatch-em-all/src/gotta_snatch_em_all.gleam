import gleam/set.{Set}
import gleam/list
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  let in_collection = set.contains(collection, card)
  let new_collection = set.insert(collection, card)
  #(in_collection, new_collection)
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let worthwhile = !set.contains(collection, their_card)
  let possible = set.contains(collection, my_card)
  let trade_result =
    collection
    |> set.delete(my_card)
    |> set.insert(their_card)
  #(worthwhile && possible, trade_result)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [] -> []
    [first, ..rest] ->
      list.fold(
        over: rest,
        from: first,
        with: fn(acc, c) { set.intersection(of: acc, and: c) },
      )
      |> set.to_list()
      |> list.sort(by: string.compare)
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  list.fold(
    over: collections,
    from: set.new(),
    with: fn(acc, c) { set.union(of: acc, and: c) },
  )
  |> set.size()
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(
    in: collection,
    for: fn(card) { string.starts_with(card, "Shiny ") },
  )
}
