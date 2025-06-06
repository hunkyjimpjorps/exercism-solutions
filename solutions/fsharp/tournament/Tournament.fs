module Tournament

type Score =
    { wins: int
      draws: int
      losses: int }
    member this.MP() = this.wins + this.losses + this.draws
    member this.P() = this.wins * 3 + this.draws

    override this.ToString() =
        $"| {this.MP(), 2} | {this.wins, 2} | {this.draws, 2} | {this.losses, 2} | {this.P(), 2}"

let emptyRecord: Score = { wins = 0; draws = 0; losses = 0 }

let addWin (winner: string) (loser: string) (table: Map<string, Score>) : Map<string, Score> =
    table
    |> Map.change winner (fun k ->
        match k with
        | Some standings -> Some { standings with wins = standings.wins + 1 }
        | None -> Some { emptyRecord with wins = 1 })
    |> Map.change loser (fun k ->
        match k with
        | Some standings -> Some { standings with losses = standings.losses + 1 }
        | None -> Some { emptyRecord with losses = 1 })

let addDraw (team1: string) (team2: string) (table: Map<string, Score>) : Map<string, Score> =
    table
    |> Map.change team1 (fun k ->
        match k with
        | Some standings -> Some { standings with draws = standings.draws + 1 }
        | None -> Some { emptyRecord with draws = 1 })
    |> Map.change team2 (fun k ->
        match k with
        | Some standings -> Some { standings with draws = standings.draws + 1 }
        | None -> Some { emptyRecord with draws = 1 })

let updateTable table (h: string) : Map<string, Score> =
    match h.Split(';') with
    | [| team1; team2; "win" |] -> addWin team1 team2 table
    | [| team1; team2; "loss" |] -> addWin team2 team1 table
    | [| team1; team2; "draw" |] -> addDraw team1 team2 table
    | _ -> failwith "Invalid match format"

let tally (input: string list) : string list =
    input
    |> List.fold updateTable Map.empty
    |> Map.toList
    |> List.sortByDescending (fun (_, r) -> r.P())
    |> List.map (fun (team, score) -> $"{team, -30} {score}")
    |> List.append [ "Team                           | MP |  W |  D |  L |  P" ]
