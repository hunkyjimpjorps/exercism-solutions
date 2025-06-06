module CustomSet

type CustomSet = Map<int, bool>

let empty: CustomSet = Map.empty

let isEmpty (set: CustomSet) = set.IsEmpty

let size (set: CustomSet) : int = set.Count

let fromList (list: int list) : CustomSet =
    list
    |> List.map (fun i -> (i, true))
    |> Map.ofList

let toList (set: CustomSet) = Map.keys set

let contains value (set: CustomSet) = Map.containsKey value set

let insert value (set: CustomSet) : CustomSet = Map.add value true set

let union (left: CustomSet) (right: CustomSet) : CustomSet =
    Map.fold (fun acc k v -> Map.add k v acc) right left

let intersection (left: CustomSet) (right: CustomSet) : CustomSet =
    Map.fold
        (fun acc k v ->
            if Map.containsKey k right then
                Map.add k v acc
            else
                acc)
        empty
        left

let difference (left: CustomSet) (right: CustomSet) : CustomSet =
    Map.fold
        (fun acc k v ->
            if Map.containsKey k right then
                acc
            else
                Map.add k v acc)
        empty
        left

let isEqualTo (left: CustomSet) (right: CustomSet) = left = right

let isSubsetOf (left: CustomSet) (right: CustomSet) : bool =
    Map.forall (fun k _ -> Map.containsKey k right) left

let isDisjointFrom (left: CustomSet) (right: CustomSet) = intersection left right = empty
