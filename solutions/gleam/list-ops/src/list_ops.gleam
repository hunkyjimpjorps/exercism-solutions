pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  case first {
    [] -> second
    [h, ..t] -> [h, ..append(t, second)]
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  case lists {
    [] -> []
    [h, ..t] -> append(h, concat(t))
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  case list {
    [] -> []
    [h, ..t] ->
      case function(h) {
        True -> [h, ..filter(t, function)]
        False -> filter(t, function)
      }
  }
}

pub fn length(list: List(a)) -> Int {
  case list {
    [] -> 0
    [_, ..t] -> 1 + length(t)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [h, ..t] -> [function(h), ..map(t, function)]
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [h, ..t] -> foldl(t, function(initial, h), function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  foldl(reverse(list), initial, function)
}

pub fn reverse(list: List(a)) -> List(a) {
  foldl(list, [], prepend)
}

fn prepend(b, a) {
  [a, ..b]
}
