import gleam/deque.{type Deque}

pub fn insert_top(deque: Deque(Int), card: Int) {
  deque.push_back(deque, card)
}

pub fn remove_top_card(deque: Deque(Int)) -> Deque(Int) {
  case deque.pop_back(deque) {
    Error(Nil) -> deque
    Ok(#(_, new_q)) -> new_q
  }
}

pub fn insert_bottom(deque: Deque(Int), card: Int) -> Deque(Int) {
  deque.push_front(deque, card)
}

pub fn remove_bottom_card(deque: Deque(Int)) -> Deque(Int) {
  case deque.pop_front(deque) {
    Error(Nil) -> deque
    Ok(#(_, new_q)) -> new_q
  }
}

pub fn check_size_of_stack(deque: Deque(Int), target: Int) -> Bool {
  deque.length(deque) == target
}
