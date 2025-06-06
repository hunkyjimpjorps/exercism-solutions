module RobotName

type Robot = { name: string }

type RobotReply =
    | NextName of AsyncReplyChannel<string>
    | Reset of string * AsyncReplyChannel<string>

let r = System.Random()
let shuffle (r: System.Random) = List.sortBy (fun _ -> r.Next())

let startingNames =
    [ for c1 in 'A' .. 'Z' do
          for c2 in 'A' .. 'Z' do
              for num in 1..999 -> $"{c1}{c2}{num:D3}" ]
    |> shuffle r

let robotNameGenerator =
    MailboxProcessor.Start(fun inbox ->
        let rec loop names =
            async {
                let! msg = inbox.Receive()

                match msg with
                | NextName(channel) ->
                    channel.Reply(List.head names)
                    return! loop (List.tail names)
                | Reset(old_name, channel) ->
                    channel.Reply(List.head names)
                    return! loop (shuffle r (old_name :: List.tail names))
            }

        loop startingNames)

let mkRobot () : Robot =
    let new_name = robotNameGenerator.PostAndReply(fun c -> NextName c)
    { name = new_name }

let name (robot: Robot) : string = robot.name

let reset (robot: Robot) : Robot =
    let new_name = robotNameGenerator.PostAndReply(fun c -> Reset(robot.name, c))
    { robot with name = new_name }
