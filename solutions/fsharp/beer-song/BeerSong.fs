module BeerSong

let generateLine (bottles: int) : string list =
    let s_before =
        match bottles with
        | 1 -> ""
        | _ -> "s"

    let bottles_before =
        match bottles with
        | 0 -> "No more"
        | _ -> string bottles

    let bottles_after =
        match bottles with
        | 1 -> "no more"
        | 0 -> "99"
        | _ -> string (bottles - 1)

    let refrain =
        match bottles with
        | 0 -> "Go to the store and buy some more"
        | 1 -> "Take it down and pass it around"
        | _ -> "Take one down and pass it around"

    let s_after =
        match bottles_after with
        | "1" -> ""
        | _ -> "s"

    [ $"{bottles_before} bottle{s_before} of beer on the wall, {bottles_before.ToLower()} bottle{s_before} of beer."
      $"{refrain}, {bottles_after} bottle{s_after} of beer on the wall." ]

let rec recite (bottles: int) (takeDown: int) : string list =
    match takeDown with
    | 1 -> generateLine bottles
    | _ -> List.append (List.append (generateLine bottles) [ "" ]) (recite (bottles - 1) (takeDown - 1))
