module GradeSchool

type School = Map<int, string list>

let empty : School = Map.empty

let add (student: string) (grade: int) (school: School) : School =
    match Map.containsKey grade school with
    | true -> Map.add grade (student :: school.[grade]) school
    | false -> Map.add grade [ student ] school

let roster (school: School) : string list =
    school
    |> Map.toList
    |> List.map (fun x -> snd x)
    |> List.map (List.sort)
    |> List.concat

let grade (number: int) (school: School) : string list =
    school
    |> Map.containsKey number
    |> function
    | true -> school.[number] |> List.sort
    | false -> []
