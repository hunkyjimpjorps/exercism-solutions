module ComplexNumbers

open System

type MyComplexNumber = { r: double; i: double }

let create real imaginary = { r = real; i = imaginary }

let mul z1 z2 =
    { r = z1.r * z2.r - z1.i * z2.i
      i = z1.i * z2.r + z1.r * z2.i }

let add z1 z2 = { r = z1.r + z2.r; i = z1.i + z2.i }

let sub z1 z2 = add z1 { r = -z2.r; i = -z2.i }

let div z1 z2 =
    { r =
          (z1.r * z2.r + z1.i * z2.i)
          / (pown z2.r 2 + pown z2.i 2)
      i =
          (z1.i * z2.r - z1.r * z2.i)
          / (pown z2.r 2 + pown z2.i 2) }

let abs (z: MyComplexNumber) = sqrt (pown z.r 2 + pown z.i 2)

let conjugate z = { z with i = -z.i }

let real z = z.r

let imaginary z = z.i

let exp z =
    { r = Math.Exp z.r * Math.Cos z.i
      i = Math.Exp z.r * Math.Sin z.i }
