import gleam/yielder.{type Yielder}

pub type Item {
  Item(name: String, price: Int, quantity: Int)
}

pub fn item_names(items: Yielder(Item)) -> Yielder(String) {
  yielder.map(items, with: fn(i) { i.name })
}

pub fn cheap(items: Yielder(Item)) -> Yielder(Item) {
  yielder.filter(items, keeping: fn(i) { i.price < 30 })
}

pub fn out_of_stock(items: Yielder(Item)) -> Yielder(Item) {
  yielder.filter(items, keeping: fn(i) { i.quantity == 0 })
}

pub fn total_stock(items: Yielder(Item)) -> Int {
  yielder.fold(over: items, from: 0, with: fn(acc, i) { acc + i.quantity })
}
 