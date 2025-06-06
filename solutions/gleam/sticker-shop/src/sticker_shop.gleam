import gleam/list

pub type Usd

pub type Eur

pub type Jpy

pub opaque type Money(currency) {
  Money(value: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  list.fold(
    over: prices,
    from: Money(0),
    with: fn(total, m) { Money(total.value + m.value) },
  )
}
