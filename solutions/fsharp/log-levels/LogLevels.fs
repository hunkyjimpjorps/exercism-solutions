module LogLevels

open System.Text.RegularExpressions

let rxParseLogLine = Regex("\[(\w+?)\]:\s*(.+?)\s*$", RegexOptions.Compiled)

let message (logLine: string) : string =
    rxParseLogLine.Match(logLine).Groups[2].Value

let logLevel (logLine: string) : string =
    rxParseLogLine
        .Match(logLine)
        .Groups[ 1 ]
        .Value.ToLower()

let reformat (logLine: string) : string =
    $"{message logLine} ({logLevel logLine})"
