module FoodChain

type Animal = { animal: string; rhyme: string }

let verseToAnimal verse =
    match verse with
    | 1 ->
        { animal = "fly"
          rhyme = "I don't know why she swallowed the fly. Perhaps she'll die." }
    | 2 ->
        { animal = "spider"
          rhyme = "It wriggled and jiggled and tickled inside her." }
    | 3 ->
        { animal = "bird"
          rhyme = "How absurd to swallow a bird!" }
    | 4 ->
        { animal = "cat"
          rhyme = "Imagine that, to swallow a cat!" }
    | 5 ->
        { animal = "dog"
          rhyme = "What a hog, to swallow a dog!" }
    | 6 ->
        { animal = "goat"
          rhyme = "Just opened her throat and swallowed a goat!" }
    | 7 ->
        { animal = "cow"
          rhyme = "I don't know how she swallowed a cow!" }
    | 8 ->
        { animal = "horse"
          rhyme = "She's dead, of course!" }
    | _ -> failwith "Invalid verse number"

let addLine newline source = List.append source [ newline ]

let rec intersperse (ins: 'T) (lst: 'T list) : 'T list =
    match lst with
    | [] -> []
    | h :: [] -> [ h ]
    | h :: t -> h :: ins :: intersperse ins t

let spiderRule s =
    match s with
    | "spider" -> "spider that wriggled and jiggled and tickled inside her"
    | s -> s

let iterativeVersePart n : string list =
    [ for l in n .. -1 .. 2 do
          yield
              $"She swallowed the {(verseToAnimal l).animal} \
             to catch the {spiderRule (verseToAnimal (l - 1)).animal}." ]
    |> List.append [ (verseToAnimal n).rhyme ]
    |> addLine (verseToAnimal 1).rhyme

let makeVerse n =
    match n with
    | n when n >= 2 && n <= 7 -> iterativeVersePart n
    | n when n = 1 || n = 8 -> [ (verseToAnimal n).rhyme ]
    | _ -> failwith "Invalid verse number"
    |> List.append [ $"I know an old lady who swallowed a {(verseToAnimal n).animal}." ]

let recite start stop : string list =
    [ for v in start .. stop do
          yield makeVerse v ]
    |> intersperse [ "" ]
    |> List.concat
