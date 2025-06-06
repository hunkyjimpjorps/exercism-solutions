module Yacht

type Category =
    | Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht

type Die =
    | One = 1
    | Two = 2
    | Three = 3
    | Four = 4
    | Five = 5
    | Six = 6

let nOfKind (die: Die) (hand: Die list) : int =
    List.filter ((=) die) hand |> List.sumBy int

let dieSum (hand: Die list) : int = hand |> List.sumBy int

let checkStraightLacking (die: Die) (hand: Die list) : int =
    if
        hand |> List.distinct |> List.length = 5
        && not (List.exists ((=) die) hand)
    then
        30
    else
        0

let checkFullHouse (hand: Die list) =
    if hand |> List.countBy id |> List.minBy snd |> snd = 2 then
        dieSum hand
    else
        0

let check4OfKind (hand: Die list) =
    let dieCount =
        hand |> List.countBy id |> List.maxBy snd

    if snd dieCount >= 4 then
        4 * (int (fst dieCount))
    else
        0

let checkYacht (hand: Die list) =
    if hand |> List.distinct |> List.length = 1 then
        50
    else
        0

let score category dice =
    dice
    |> match category with
       | Ones -> nOfKind Die.One
       | Twos -> nOfKind Die.Two
       | Threes -> nOfKind Die.Three
       | Fours -> nOfKind Die.Four
       | Fives -> nOfKind Die.Five
       | Sixes -> nOfKind Die.Six
       | FullHouse -> checkFullHouse
       | FourOfAKind -> check4OfKind
       | LittleStraight -> checkStraightLacking Die.Six
       | BigStraight -> checkStraightLacking Die.One
       | Choice -> dieSum
       | Yacht -> checkYacht
