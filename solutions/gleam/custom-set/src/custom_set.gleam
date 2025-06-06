import gleam/map.{Map, keys}
import gleam/list

pub opaque type Set(t) {
  Set(contents: Map(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  Set(
    members
    |> list.map(fn(m) { #(m, True) })
    |> map.from_list(),
  )
}

pub fn is_empty(set: Set(t)) -> Bool {
  map.size(set.contents) == 0
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  map.has_key(set.contents, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  list.all(
    in: keys(first.contents),
    satisfying: list.contains(keys(second.contents), _),
  )
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  !list.any(
    in: keys(first.contents),
    satisfying: list.contains(keys(second.contents), _),
  )
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  is_subset(first, second) && is_subset(second, first)
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  Set(map.insert(set.contents, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  list.filter(keys(first.contents), list.contains(keys(second.contents), _))
  |> new()
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  list.filter(
    keys(first.contents),
    fn(c) { !list.contains(keys(second.contents), c) },
  )
  |> new()
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  list.append(keys(first.contents), keys(second.contents))
  |> list.unique()
  |> new()
}
