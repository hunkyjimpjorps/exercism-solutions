module SimpleCipher

open System
open MathNet.Numerics

let allowableLetters = [| 'a' .. 'z' |]
let keyLength = 100
let private rand = Random()

let private rChar () =
    allowableLetters.[rand.Next(allowableLetters.Length)]

let private index element =
    Array.findIndex ((=) element) allowableLetters

type SimpleCipher(key: string) =
    let plainCharToEncodedChar plainChar keyChar =
        index plainChar + index keyChar
        |> (fun c -> Euclid.Modulus(c, allowableLetters.Length))
        |> (fun i -> allowableLetters.[i])

    let encodedCharToPlainChar encodedChar keyChar =
        index encodedChar - index keyChar
        |> (fun c -> Euclid.Modulus(c, allowableLetters.Length))
        |> (fun i -> allowableLetters.[i])

    let extendKeyLength (str: string) (key: string) =
        if str.Length > key.Length then
            key
            |> Seq.replicate (str.Length / key.Length + 1)
            |> System.String.Concat
        else
            key

    member __.Key = key

    member __.Encode(plaintext: string) =
        let key = extendKeyLength plaintext __.Key

        Seq.map2 plainCharToEncodedChar plaintext key
        |> System.String.Concat

    member __.Decode(ciphertext: string) =
        let key = extendKeyLength ciphertext __.Key

        Seq.map2 encodedCharToPlainChar ciphertext key
        |> System.String.Concat

    new() =
        SimpleCipher(
            [| for i in 1 .. 100 do
                   yield rChar () |]
            |> String.Concat
        )
