import gleam/map.{type Map}
import gleam/list

pub opaque type Set(t) {
  Set(contents: Map(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  members
  |> list.map(fn(m) { #(m, True) })
  |> map.from_list()
  |> Set()
}

pub fn is_empty(set: Set(t)) -> Bool {
  map.size(set.contents) == 0
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  map.has_key(set.contents, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  list.all(
    in: map.keys(first.contents),
    satisfying: map.has_key(second.contents, _),
  )
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  !list.any(
    in: map.keys(first.contents),
    satisfying: map.has_key(second.contents, _),
  )
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  is_subset(first, second) && is_subset(second, first)
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  Set(map.insert(set.contents, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  map.filter(first.contents, fn(c, _) { map.has_key(second.contents, c) })
  |> Set()
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  map.filter(first.contents, fn(c, _) { !map.has_key(second.contents, c) })
  |> Set()
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  map.merge(first.contents, second.contents)
  |> Set()
}
