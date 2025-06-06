module DndCharacter

let r = System.Random()

type Character =
    { Strength: int
      Dexterity: int
      Constitution: int
      Intelligence: int
      Wisdom: int
      Charisma: int
      Hitpoints: int }

let modifier x = (x - 10) / 2

let ability () =
    [for _ in 1 .. 4 do yield r.Next(1, 7) ]
    |> List.sort
    |> List.tail
    |> List.sum

let createCharacter () : Character =
    let con = ability ()

    { Strength = ability ()
      Dexterity = ability ()
      Constitution = con
      Intelligence = ability ()
      Wisdom = ability ()
      Charisma = ability ()
      Hitpoints = 10 + modifier con }
