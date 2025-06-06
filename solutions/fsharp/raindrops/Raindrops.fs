module Raindrops

let convert (n: int) : string =
    let drops = (if n % 3 = 0 then "Pling" else "") +
                (if n % 5 = 0 then "Plang" else "") +
                (if n % 7 = 0 then "Plong" else "")
    if drops = "" then string n else drops
