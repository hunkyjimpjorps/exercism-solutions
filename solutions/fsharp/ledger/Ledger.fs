module Ledger

open System
open System.Globalization

type Localization =
    { cultureIdentifier: string
      dateFormat: string
      nameDate: string
      nameDesc: string
      nameChange: string
      currency: string }

let locales : Map<string, Localization> =
    [ ("en-US",
       { cultureIdentifier = "en-US"
         dateFormat = "MM\/dd\/yyyy"
         nameDate = "Date"
         nameDesc = "Description"
         nameChange = "Change"
         currency = "¤#,#0.00 ;(¤#,#0.00)" })
      ("nl-NL",
       { cultureIdentifier = "nl-NL"
         dateFormat = "dd-MM-yyyy"
         nameDate = "Datum"
         nameDesc = "Omschrijving"
         nameChange = "Verandering"
         currency = "¤ #,#0.00 ;¤ -#,#0.00" }) ]
    |> Map.ofList

let currencyFormats : Map<string, string> =
    [ ("USD", "$"); ("EUR", "€") ] |> Map.ofList

type Entry =
    { dat: DateTime
      des: string
      chg: int }

let mkEntry date description change =
    { dat = DateTime.Parse(date, CultureInfo.InvariantCulture)
      des = description
      chg = change }

let formatLedger (currency: string) (loc: string) (entries: Entry list) : string =

    let formatDate (d: DateTime) : string = d.ToString(locales.[loc].dateFormat)

    let trimDes (s: string) : string =
        match s.Length with
        | n when n > 25 -> s.[0..21] + "..."
        | _ -> s

    let formatCurrency (n: int) : string =
        let c = float n / 100.0

        let currencyFormat =
            locales.[loc]
                .currency.Replace ("¤", currencyFormats.[currency])

        $"""{c.ToString(currencyFormat, new CultureInfo(loc))}"""

    let formatLine (x: Entry) : string =
        $"{formatDate x.dat} | {trimDes x.des, -25} | {formatCurrency x.chg, 13}"

    entries
    |> List.sortBy (fun x -> x.dat, x.des, x.chg)
    |> List.map formatLine
    |> String.concat "\n"
    |> (+) $"{locales.[loc].nameDate, -11}| {locales.[loc].nameDesc, -26}| {locales.[loc].nameChange, -13}\n"
    |> (fun s -> s.TrimEnd [| '\n' |])
