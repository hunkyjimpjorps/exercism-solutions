import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    ExtraSauce(p) -> 1 + pizza_price(p)
    ExtraToppings(p) -> 2 + pizza_price(p)
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let surcharge = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }
  do_order_price(order, 0) + surcharge
}

fn do_order_price(order, acc) {
  case order {
    [] -> acc
    [p, ..ps] -> do_order_price(ps, acc + pizza_price(p))
  }
}
