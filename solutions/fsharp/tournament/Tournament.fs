module Tournament

type Score =
    { matchesPlayed: int
      wins: int
      draws: int
      losses: int
      points: int }

let emptyRecord =
    { matchesPlayed = 0
      wins = 0
      draws = 0
      losses = 0
      points = 0 }

let updateForWin (team: string) (table: Map<string, Score>) =
    table
    |> Map.change team (fun k ->
        match k with
        | Some standings ->
            Some
                { standings with
                    matchesPlayed = standings.matchesPlayed + 1
                    wins = standings.wins + 1
                    points = standings.points + 3 }
        | None ->
            Some
                { emptyRecord with
                    matchesPlayed = 1
                    wins = 1
                    points = 3 })

let updateForLoss (team: string) (table: Map<string, Score>) =
    table
    |> Map.change team (fun k ->
        match k with
        | Some standings ->
            Some
                { standings with
                    matchesPlayed = standings.matchesPlayed + 1
                    losses = standings.losses + 1 }
        | None ->
            Some
                { emptyRecord with
                    matchesPlayed = 1
                    losses = 1 })

let updateForDraw (team: string) (table: Map<string, Score>) =
    table
    |> Map.change team (fun k ->
        match k with
        | Some standings ->
            Some
                { standings with
                    matchesPlayed = standings.matchesPlayed + 1
                    draws = standings.draws + 1
                    points = standings.points + 1 }
        | None ->
            Some
                { emptyRecord with
                    matchesPlayed = 1
                    draws = 1
                    points = 1 })


let addWin (winner: string) (loser: string) (table: Map<string, Score>) =
    table
    |> updateForWin winner
    |> updateForLoss loser

let addDraw (team1: string) (team2: string) (table: Map<string, Score>) =
    table
    |> updateForDraw team1
    |> updateForDraw team2

let updateTable table (h: string) =
    let [| team1; team2; result |] = h.Split(';')

    match result with
    | "win" -> addWin team1 team2 table
    | "loss" -> addWin team2 team1 table
    | "draw" -> addDraw team1 team2 table
    | _ -> failwith "Invalid match result"

let formatRow (row: string * Score) =
    let (team,
         { matchesPlayed = mp
           wins = w
           draws = d
           losses = l
           points = p }) =
        row

    $"{team, -30} | {mp, 2} | {w, 2} | {d, 2} | {l, 2} | {p, 2}"

let appendHeader rows =
    "Team                           | MP |  W |  D |  L |  P"
    :: rows

let tally (input: string list) =
    input
    |> List.fold updateTable Map.empty
    |> Map.toList
    |> List.sortByDescending (fun (_, r) -> r.points)
    |> List.map formatRow
    |> appendHeader
