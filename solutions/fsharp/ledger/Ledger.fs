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

let locales =
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

let currencyFormats =
    [ ("USD", "$"); ("EUR", "€") ] |> Map.ofList

type Entry =
    { dat: DateTime
      des: string
      chg: int }

let mkEntry date description change =
    { dat = DateTime.Parse(date, CultureInfo.InvariantCulture)
      des = description
      chg = change }

let formatLedger currency loc entries =

    let formatDate x =
        x.dat.ToString(locales.[loc].dateFormat)

    let trimDes x =
        match x.des.Length with
        | n when n > 25 -> x.des.[0..21] + "..."
        | _ -> x.des

    let formatCurrency x =
        let c = float x.chg / 100.0

        let currencyFormat =
            locales.[loc]
                .currency.Replace ("¤", currencyFormats.[currency])

        $"""{c.ToString(currencyFormat, new CultureInfo(loc))}"""

    let formatLine x =
        $"{formatDate x} | {trimDes x, -25} | {formatCurrency x, 13}"

    entries
    |> List.sortBy (fun x -> x.dat, x.des, x.chg)
    |> List.map formatLine
    |> String.concat "\n"
    |> (+) $"{locales.[loc].nameDate, -11}| {locales.[loc].nameDesc, -26}| {locales.[loc].nameChange, -13}\n"
    |> (fun s -> s.TrimEnd [| '\n' |])
