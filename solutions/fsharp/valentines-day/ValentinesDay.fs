module ValentinesDay

// TODO: please define the 'Approval' discriminated union type
type Approval = 
    | Yes
    | No
    | Maybe

// TODO: please define the 'Cuisine' discriminated union type
type Cuisine =
    | Korean
    | Turkish

// TODO: please define the 'Genre' discriminated union type
type Genre = 
    | Crime
    | Romance
    | Horror
    | Thriller

// TODO: please define the 'Activity' discriminated union type
type Activity =
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int

let rateActivity (activity: Activity): Approval = 
    match activity with
    | Movie Romance -> Yes
    | Restaurant Korean -> Yes 
    | Walk distance when distance < 3 -> Yes
    | Restaurant Turkish -> Maybe
    | Walk distance when distance < 5 -> Maybe
    | _ -> No