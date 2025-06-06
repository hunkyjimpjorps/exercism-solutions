import gleam/list.{filter, sort}
import gleam/string.{lowercase, to_graphemes}

fn to_grapheme_list(w: String) -> List(String) {
  w
  |> lowercase()
  |> to_graphemes()
  |> sort(string.compare)
}

fn is_anagram(w1: String, w2: String) -> Bool {
  lowercase(w1) != lowercase(w2) && to_grapheme_list(w1) == to_grapheme_list(w2)
}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  filter(candidates, fn(c) { is_anagram(word, c) })
}
