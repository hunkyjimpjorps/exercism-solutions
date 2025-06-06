module Raindrops

type divisor = int * string

let convert (n: int) : string =
    let divisorSounds : divisor list = [ 3, "Pling"; 5, "Plang"; 7, "Plong" ]

    let isDivisible ((div, sound):divisor) : string option =
        match n % div with
        | 0 -> Some sound
        | _ -> None

    let drops : string =
        List.choose isDivisible divisorSounds
        |> String.concat ""

    if drops = "" then string n else drops
