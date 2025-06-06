module ZebraPuzzle

open Microsoft.FSharp.Reflection

type HouseColor =
    | Red
    | Green
    | Ivory
    | Yellow
    | Blue

type Nationality =
    | Englishman
    | Spaniard
    | Ukranian
    | Norwegian
    | Japanese

type Pet =
    | Dog
    | Fox
    | Horse
    | Snails
    | Zebra

type Cigarette =
    | OldGold
    | Kools
    | Chesterfields
    | LuckyStrike
    | Parliaments

type Beverage =
    | Water
    | Tea
    | Milk
    | OrangeJuice
    | Coffee

type House =
    { Color: HouseColor array
      Nationality: Nationality array
      Pet: Pet array
      Cigarette: Cigarette array
      Beverage: Beverage array }

let arrayOfCases<'T> =
    FSharpType.GetUnionCases typeof<'T>
    |> Array.map (fun t -> FSharpValue.MakeUnion(t, Array.empty) :?> 'T)

let pos x = Array.findIndex ((=) x)

let rec putIn x lst =
    match lst with
    | [] -> [ [ x ] ]
    | h :: t ->
        (x :: (h :: t))
        :: (List.map (fun y -> h :: y) (putIn x t))

let makePermutations array =
    List.fold (fun x y -> List.collect (putIn y) x) [ [] ] (Array.toList array)
    |> Array.ofList
    |> Array.map Array.ofList

let colorPermutations =
    makePermutations arrayOfCases<HouseColor>
    |> Array.filter
        (fun fact ->
            1 + pos Green fact = pos Ivory fact // fact 6
            && pos Blue fact = 1) // fact 10 + fact 15

let nationalityPermutations colorPossible =
    makePermutations arrayOfCases<Nationality>
    |> Array.filter
        (fun fact ->
            pos Englishman fact = pos Red colorPossible // fact 2
            && pos Norwegian fact = 0) // fact 10

let cigarettePermutations colorPossible natPossible =
    makePermutations arrayOfCases<Cigarette>
    |> Array.filter
        (fun fact ->
            pos Parliaments fact = pos Japanese natPossible // fact 14
            && pos Kools fact = pos Yellow colorPossible) // fact 8

let beveragePermutations colorPossible natPossible cigPossible =
    makePermutations arrayOfCases<Beverage>
    |> Array.filter
        (fun fact ->
            pos Coffee fact = pos Green colorPossible // fact 4
            && pos Tea fact = pos Ukranian natPossible // fact 5
            && pos Milk fact = 2 // fact 9
            && pos OrangeJuice fact = pos LuckyStrike cigPossible) // fact 13

let petPermutations colorPossible natPossible cigPossible drinkPossible =
    makePermutations arrayOfCases<Pet>
    |> Array.filter
        (fun fact ->
            pos Dog fact = pos Spaniard natPossible // fact 3
            && pos Snails fact = pos OldGold cigPossible // fact 7
            && (pos Fox fact = pos Chesterfields cigPossible + 1
                || pos Fox fact = pos Chesterfields cigPossible - 1) // fact 11
            && (pos Horse fact = pos Kools cigPossible + 1
                || pos Horse fact = pos Kools cigPossible - 1)) // fact 12

let applyConstraints =
    seq {
        for color in colorPermutations do
            for nat in nationalityPermutations color do
                for cig in cigarettePermutations color nat do
                    for drink in beveragePermutations color nat cig do
                        for pet in petPermutations color nat cig drink do
                            yield
                                { Color = color
                                  Nationality = nat
                                  Cigarette = cig
                                  Beverage = drink
                                  Pet = pet }
    }
    |> Seq.head

let drinksWater =
    pos Water applyConstraints.Beverage
    |> Array.get applyConstraints.Nationality

let ownsZebra =
    pos Zebra applyConstraints.Pet
    |> Array.get applyConstraints.Nationality
