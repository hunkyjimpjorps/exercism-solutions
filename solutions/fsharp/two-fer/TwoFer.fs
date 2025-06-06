module TwoFer

let twoFer (input: string option) : string =
    $"""One for {Option.defaultValue "you" input}, one for me."""