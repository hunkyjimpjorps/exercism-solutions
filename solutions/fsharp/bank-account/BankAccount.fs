module BankAccount

type Transaction =
    | Open
    | Close
    | Balance of AsyncReplyChannel<decimal option>
    | Add of decimal

type BankAccount = MailboxProcessor<Transaction>

let accountMailbox (account: BankAccount) : decimal option -> Async<'a> =
    let rec agentLoop (balance: decimal option) =
        async {
            let! message = account.Receive()

            match message with
            | Open -> return! agentLoop (Some 0.0m)
            | Close -> return! agentLoop None
            | Balance(ch) ->
                ch.Reply balance
                return! agentLoop balance
            | Add(d) -> return! balance |> Option.map (fun b -> b + d) |> agentLoop
        }

    agentLoop


let mkBankAccount () : MailboxProcessor<Transaction> =
    MailboxProcessor.Start(fun acc -> accountMailbox acc None)

let openAccount (account: BankAccount) : BankAccount =
    account.Post Open
    account

let closeAccount (account: BankAccount) : BankAccount =
    account.Post Close
    account

let getBalance (account: BankAccount) : decimal option = account.PostAndReply Balance

let updateBalance (change: decimal) (account: BankAccount) : BankAccount =
    account.Post(Add change)
    account
