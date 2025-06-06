module PythagoreanTriplet

let intSqrt : int -> int = float >> sqrt >> int

let tripletsWithSum (sum: int) : (int * int * int) list =
    let mutable triplets = []

    let aMax = intSqrt (pown sum 2 + 1)

    for a = 1 to aMax do
        let bMax = (intSqrt (pown sum 2 - pown a 2)) + 1

        for b = (a + 1) to bMax do
            let c = (sum - a - b)

            if (pown a 2) + (pown b 2) = (pown c 2) then
                triplets <- triplets @ [ (a, b, c) ]

    triplets
