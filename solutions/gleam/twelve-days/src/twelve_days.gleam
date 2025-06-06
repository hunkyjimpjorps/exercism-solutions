import gleam/list
import gleam/string

pub fn verse(number: Int) -> String {
  case
    list.range(1, number)
    |> list.map(gift)
  {
    [one] -> intro(number) <> one
    [first, ..rest] ->
      ["and " <> first, ..rest]
      |> list.reverse()
      |> string.join(", ")
      |> string.append(intro(number), _)
  }
}

pub fn lyrics(from starting_verse: Int, to ending_verse: Int) -> String {
  list.range(starting_verse, ending_verse)
  |> list.map(verse)
  |> string.join("\n")
}

fn intro(nth: Int) -> String {
  "On the " <> ordinal(nth) <> " day of Christmas my true love gave to me: "
}

fn ordinal(nth: Int) -> String {
  case nth {
    1 -> "first"
    2 -> "second"
    3 -> "third"
    4 -> "fourth"
    5 -> "fifth"
    6 -> "sixth"
    7 -> "seventh"
    8 -> "eighth"
    9 -> "ninth"
    10 -> "tenth"
    11 -> "eleventh"
    12 -> "twelfth"
  }
}

fn gift(day: Int) -> String {
  case day {
    12 -> "twelve Drummers Drumming"
    11 -> "eleven Pipers Piping"
    10 -> "ten Lords-a-Leaping"
    9 -> "nine Ladies Dancing"
    8 -> "eight Maids-a-Milking"
    7 -> "seven Swans-a-Swimming"
    6 -> "six Geese-a-Laying"
    5 -> "five Gold Rings"
    4 -> "four Calling Birds"
    3 -> "three French Hens"
    2 -> "two Turtle Doves"
    1 -> "a Partridge in a Pear Tree."
  }
}
