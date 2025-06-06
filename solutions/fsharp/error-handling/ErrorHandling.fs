module ErrorHandling
open System

let handleErrorByThrowingException () = failwith "This is an exception"

let handleErrorByReturningOption input =
    match input with
    | "1" -> Some 1
    | _ -> None

let handleErrorByReturningResult input =
    match input with
    | "1" -> Ok 1
    | _ -> Error "Could not convert input to integer"

let bind switchFunction twoTrackInput =
    match twoTrackInput with
    | Ok s -> switchFunction s
    | Error f -> Error f

let cleanupDisposablesWhenThrowingException (resource : IDisposable) =
    try
        failwith "This is an exception"
    finally
        resource.Dispose()
