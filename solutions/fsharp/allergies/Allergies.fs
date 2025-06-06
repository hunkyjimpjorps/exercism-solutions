module Allergies

open System

[<Flags>]
type Allergen =
    | Eggs = 1
    | Peanuts = 2
    | Shellfish = 4
    | Strawberries = 8
    | Tomatoes = 16
    | Chocolate = 32
    | Pollen = 64
    | Cats = 128

let list (codedAllergies: int) =
    Enum.GetValues(typeof<Allergen>) :?> (Allergen [])
    |> Array.toList
    |> List.filter (fun a -> a &&& enum<Allergen> (codedAllergies) = a)

let allergicTo (codedAllergies: int) (allergen: Allergen) : bool =
    Seq.contains allergen (list codedAllergies)
