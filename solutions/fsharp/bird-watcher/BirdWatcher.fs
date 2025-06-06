module BirdWatcher

let lastWeek: int [] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday (counts: int []) : int = counts[counts.Length - 2]

let total: (int [] -> int) = Array.sum

let dayWithoutBirds: (int [] -> bool) = Array.exists (fun n -> n = 0)

let incrementTodaysCount (counts: int []) : int [] =
    let today = Array.last counts + 1
    Array.updateAt (counts.Length - 1) today counts

let equals (n: int) ((_i, c): int * int) : bool = n = c

let oddWeek (counts: int []) : bool =
    let indexedCounts = Array.indexed counts
    let odds, evens = Array.partition (fun (i, c) -> i % 2 = 0) indexedCounts

    Array.forall (equals 10) evens
    || Array.forall (equals 0) evens
    || Array.forall (equals 5) odds
