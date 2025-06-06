import gleam/list
import gleam/string

type Character {
  Character(name: String, verb: String)
}

const agents = [
  Character("house", "Jack built."),
  Character("malt", "lay in"),
  Character("rat", "ate"),
  Character("cat", "killed"),
  Character("dog", "worried"),
  Character("cow with the crumpled horn", "tossed"),
  Character("maiden all forlorn", "milked"),
  Character("man all tattered and torn", "kissed"),
  Character("priest all shaven and shorn", "married"),
  Character("rooster that crowed in the morn", "woke"),
  Character("farmer sowing his corn", "kept"),
  Character("horse and the hound and the horn", "belonged to"),
]

pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  list.range(start_verse, end_verse)
  |> list.map(verse)
  |> string.join(with: "\n")
}

fn verse(verse) -> String {
  agents
  |> list.take(verse)
  |> list.reverse()
  |> list.map(describe_character)
  |> list.prepend("This is")
  |> string.join(with: " ")
}

fn describe_character(character: Character) -> String {
  "the " <> character.name <> " that " <> character.verb
}
