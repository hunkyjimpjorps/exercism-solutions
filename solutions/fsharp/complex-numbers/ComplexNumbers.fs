module ComplexNumbers

open System

type MyComplexNumber = { Re: double; Im: double }

let create real imaginary = { Re = real; Im = imaginary }

let mul z1 z2 =
    { Re = z1.Re * z2.Re - z1.Im * z2.Im
      Im = z1.Im * z2.Re + z1.Re * z2.Im }

let add z1 z2 = { Re = z1.Re + z2.Re; Im = z1.Im + z2.Im }

let sub z1 z2 = add z1 { Re = -z2.Re; Im = -z2.Im }

let div z1 z2 =
    { Re =
          (z1.Re * z2.Re + z1.Im * z2.Im)
          / (pown z2.Re 2 + pown z2.Im 2)
      Im =
          (z1.Im * z2.Re - z1.Re * z2.Im)
          / (pown z2.Re 2 + pown z2.Im 2) }

let abs z = sqrt (pown z.Re 2 + pown z.Im 2)

let conjugate z = { z with Im = -z.Im }

let real z = z.Re

let imaginary z = z.Im

let exp z =
    { Re = Math.Exp z.Re * Math.Cos z.Im
      Im = Math.Exp z.Re * Math.Sin z.Im }
