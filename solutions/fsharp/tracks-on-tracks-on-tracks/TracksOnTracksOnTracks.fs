module TracksOnTracksOnTracks

let newList: string list = []

let existingList: string list = [ "F#"; "Clojure"; "Haskell" ]

let addLanguage (language: string) (languages: string list) : string list = language :: languages

let countLanguages = List.length

let reverseList = List.rev

let excitingList (languages: string list) : bool =
    match languages with
    | "F#" :: _rest -> true
    | [ _; "F#" ] -> true
    | [ _; "F#"; _ ] -> true
    | _ -> false
