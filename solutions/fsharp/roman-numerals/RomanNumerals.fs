module RomanNumerals

let romanNumerals: (string * int) list =
    [ ("M", 1000)
      ("CM", 900)
      ("D", 500)
      ("CD", 400)
      ("C", 100)
      ("XC", 90)
      ("L", 50)
      ("XL", 40)
      ("X", 10)
      ("IX", 9)
      ("V", 5)
      ("IV", 4)
      ("I", 1) ]

let rec doNextNumeral n conv =
    match conv with
    | [] -> ""
    | (_, value) :: rest when value > n -> doNextNumeral n rest
    | (sym, value) :: _ -> sym + doNextNumeral (n - value) conv

let roman arabicNumeral =
    doNextNumeral arabicNumeral romanNumerals
