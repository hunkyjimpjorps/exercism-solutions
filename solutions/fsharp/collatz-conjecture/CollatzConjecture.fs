module CollatzConjecture

let steps (number: int) : int option =
    let rec nextStep (number: int) (step: int) : int option =
        match number with
        | 1 -> Some step
        | n when n % 2 = 0 -> nextStep (n / 2) (step + 1)
        | n -> nextStep (3 * n + 1) (step + 1)

    match number with
    | n when n <= 0 -> None
    | n -> nextStep n 0
