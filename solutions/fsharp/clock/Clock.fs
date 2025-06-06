module Clock

open FSharpPlus.Math.Generic

type Clock(hours: int, minutes: int) =
    member this.Hours =
        remE (remE hours 24 + divE minutes 60) 24

    member this.Minutes = remE minutes 60

    override this.Equals(otherClock) : bool =
        match otherClock with
        | :? Clock as other ->
            this.Hours = other.Hours
            && this.Minutes = other.Minutes
        | _ -> false

    override this.GetHashCode() = hash this.Hours ^^^ hash this.Minutes

let create hours minutes : Clock = new Clock(hours, minutes)

let add minutes (clock: Clock) =
    new Clock(clock.Hours, clock.Minutes + minutes)

let subtract minutes (clock: Clock) =
    new Clock(clock.Hours, clock.Minutes - minutes)

let display (clock: Clock) = $"{clock.Hours:D2}:{clock.Minutes:D2}"
