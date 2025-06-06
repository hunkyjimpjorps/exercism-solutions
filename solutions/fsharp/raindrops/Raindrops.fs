module Raindrops

let convert (n: int) : string =
    let divisorSounds = [ 3, "Pling"; 5, "Plang"; 7, "Plong" ]

    let isDivisible (div, sound) =
        match n % div with
        | 0 -> Some sound
        | _ -> None

    let drops =
        List.choose isDivisible divisorSounds
        |> String.concat ""

    if drops = "" then string n else drops
