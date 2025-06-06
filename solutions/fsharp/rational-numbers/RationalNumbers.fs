module RationalNumbers

type Rational = { num: int; den: int }

let rec gcd a b =
    match b with
    | 0 -> a
    | _ -> gcd b (a % b)

let reduce r =
    let g = gcd r.num r.den
    { num = r.num / g; den = r.den / g }

let create num den = reduce { num = num; den = den }

let add r1 r2 =
    reduce
        { num = r1.num * r2.den + r2.num * r1.den
          den = r1.den * r2.den }

let sub r1 r2 = add r1 { r2 with num = -1 * r2.num }

let mul r1 r2 =
    reduce
        { num = r1.num * r2.num
          den = r1.den * r2.den }

let div r1 r2 = mul r1 { num = r2.den; den = r2.num }

let abs r =
    reduce { num = abs r.num; den = abs r.den }

let exprational n r =
    reduce
        { num = pown r.num n
          den = pown r.den n }

let expreal r (n: int) : float = float n ** (float r.num / float r.den)
