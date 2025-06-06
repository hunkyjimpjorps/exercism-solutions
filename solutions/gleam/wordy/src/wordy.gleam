import gleam/int
import gleam/list
import gleam/string
import gleam/result
import gleam/regex.{Match}
import gleam/option.{None, Some}

pub type Error {
  SyntaxError
  UnknownOperation
  ImpossibleOperation
}

type Token {
  Number(Int)
  Operation(Op)
}

type Op {
  Add
  Subtract
  Multiply
  Divide
}

pub fn answer(question: String) -> Result(Int, Error) {
  question
  |> is_valid_question_format()
  |> result.map(string.split(_, " "))
  |> result.then(tokenify(_, []))
  |> result.then(parse(_))
}

fn is_valid_question_format(question: String) -> Result(String, Error) {
  let assert Ok(re) = regex.from_string("^What is\\s?(.*)\\?$")
  case regex.scan(with: re, content: question) {
    [] -> Error(UnknownOperation)
    [Match(submatches: [None], ..)] -> Error(SyntaxError)
    [Match(submatches: [Some(str)], ..)] -> Ok(str)
  }
}

fn tokenify(
  question: List(String),
  acc: List(Token),
) -> Result(List(Token), Error) {
  case question {
    [] -> Ok(list.reverse(acc))
    ["plus", ..rest] -> tokenify(rest, [Operation(Add), ..acc])
    ["minus", ..rest] -> tokenify(rest, [Operation(Subtract), ..acc])
    ["multiplied", "by", ..rest] -> tokenify(rest, [Operation(Multiply), ..acc])
    ["divided", "by", ..rest] -> tokenify(rest, [Operation(Divide), ..acc])
    [n, ..rest] ->
      case int.parse(n) {
        Ok(i) -> tokenify(rest, [Number(i), ..acc])
        Error(Nil) -> Error(UnknownOperation)
      }
  }
}

fn parse(tokens: List(Token)) -> Result(Int, Error) {
  case tokens {
    [Number(n)] -> Ok(n)
    [_, Operation(Divide), Number(0), ..] -> Error(ImpossibleOperation)
    [Number(a), Operation(op), Number(b), ..rest] ->
      parse([Number(op_to_function(op)(a, b)), ..rest])
    _ -> Error(SyntaxError)
  }
}

fn op_to_function(op: Op) -> fn(Int, Int) -> Int {
  case op {
    Add -> int.add
    Subtract -> int.subtract
    Multiply -> int.multiply
    Divide -> fn(a, b) { a / b }
  }
}
