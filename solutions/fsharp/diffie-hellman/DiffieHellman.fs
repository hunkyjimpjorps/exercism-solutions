module DiffieHellman

open System

let rand = Random()

let privateKey (primeP: bigint) : bigint =
    rand.NextInt64(2, int64 primeP) |> bigint

let publicKey (primeP: bigint) (primeG: bigint) (privateKey: bigint) : bigint = primeG ** (int privateKey) % primeP

let secret (primeP: bigint) (publicKey: bigint) (privateKey: bigint) : bigint = publicKey ** (int privateKey) % primeP
