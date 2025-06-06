module Anagram

open FSharpPlus

let sortChars =
    (fun (s: string) -> s.ToLower())
    >> Seq.toArray
    >> Array.sort

let checkAnagram (mainWord: string) (candidate: string) =
    sortChars candidate = sortChars mainWord
    && candidate.ToLower() <> mainWord.ToLower()

let findAnagrams candidates mainWord =
    List.filter (checkAnagram mainWord) candidates
