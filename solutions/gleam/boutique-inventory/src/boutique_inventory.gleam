import gleam/iterator.{Iterator}

pub type Item {
  Item(name: String, price: Int, quantity: Int)
}

pub fn item_names(items: Iterator(Item)) -> Iterator(String) {
  iterator.map(items, with: fn(i) { i.name })
}

pub fn cheap(items: Iterator(Item)) -> Iterator(Item) {
  iterator.filter(items, for: fn(i) { i.price < 30 })
}

pub fn out_of_stock(items: Iterator(Item)) -> Iterator(Item) {
  iterator.filter(items, for: fn(i) { i.quantity == 0 })
}

pub fn total_stock(items: Iterator(Item)) -> Int {
  iterator.fold(over: items, from: 0, with: fn(acc, i) { acc + i.quantity })
}
