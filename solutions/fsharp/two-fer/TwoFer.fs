module TwoFer

let twoFer input =
    match input with
    | None -> "you"
    | Some name -> name
    |> sprintf "One for %s, one for me."
