import gleam/int
import gleam/list
import gleam/string
import gleam/map.{type Map}

pub type Forth {
  Forth(
    program: List(ForthType),
    stack: List(ForthType),
    definitions: Map(ForthType, ForthOp(ForthType)),
  )
}

pub type ForthType {
  Number(Int)
  Word(String)
  StartDef
  EndDef
}

pub type ForthOp(a) {
  BinaryMathOp(fn(a, a) -> Result(a, ForthError))
  ListOp(fn(List(a)) -> Result(List(a), ForthError))
  CustomOp(List(a))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub fn new() -> Forth {
  Forth(program: [], stack: [], definitions: standard_library())
}

pub fn format_stack(f: Forth) -> String {
  f.stack
  |> list.reverse()
  |> list.map(represent_token)
  |> string.join(" ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  prog
  |> tokenize_input
  |> Forth(program: _, stack: f.stack, definitions: f.definitions)
  |> run_program(_)
}

fn tokenize_input(prog: String) -> List(ForthType) {
  prog
  |> string.uppercase()
  |> string.split(" ")
  |> list.map(identify_token)
}

fn identify_token(word: String) -> ForthType {
  case word {
    ":" -> StartDef
    ";" -> EndDef
    w ->
      case int.parse(w) {
        Ok(n) -> Number(n)
        Error(Nil) -> Word(w)
      }
  }
}

fn represent_token(word: ForthType) -> String {
  case word {
    StartDef -> ":"
    EndDef -> ";"
    Number(n) -> int.to_string(n)
    Word(w) -> w
  }
}

fn run_program(forth: Forth) -> Result(Forth, ForthError) {
  case forth.program, forth.stack {
    [StartDef, ..rest], _ ->
      case attempt_definition(rest, forth) {
        Ok(#(name, ops, program_rest)) ->
          forth.definitions
          |> map.insert(name, CustomOp(ops))
          |> Forth(stack: forth.stack, program: program_rest, definitions: _)
          |> run_program()
        Error(err) -> Error(err)
      }
    _, [Word(w), ..rest] ->
      case map.get(forth.definitions, Word(w)) {
        Ok(CustomOp(ops)) ->
          ops
          |> list.append(forth.program)
          |> Forth(stack: rest, program: _, definitions: forth.definitions)
          |> run_program()
        Ok(ListOp(f)) ->
          case f(rest) {
            Ok(new_stack) -> run_program(Forth(..forth, stack: new_stack))
            Error(err) -> Error(err)
          }
        Error(Nil) -> Error(UnknownWord)
      }
    [], _ -> Ok(forth)
    [next, ..rest], s ->
      run_program(Forth(..forth, program: rest, stack: [next, ..s]))
  }
}

fn attempt_definition(
  words: List(ForthType),
  forth: Forth,
) -> Result(#(ForthType, List(ForthType), List(ForthType)), ForthError) {
  case words {
    [Word(w), ..rest] -> {
      let #(ops, [EndDef, ..stack]) =
        list.split_while(rest, fn(w) { w != EndDef })
      let ops = list.flat_map(ops, parse_with_context(_, forth))
      Ok(#(Word(string.uppercase(w)), ops, stack))
    }
    _ -> Error(InvalidWord)
  }
}

fn parse_with_context(op: ForthType, f: Forth) -> List(ForthType) {
  case op {
    Word(_) as w ->
      case map.get(f.definitions, w) {
        Ok(CustomOp(ops)) -> ops
        Ok(_) -> [w]
        _ -> []
      }
    op -> [op]
  }
}

pub fn standard_library() -> Map(ForthType, ForthOp(ForthType)) {
  [
    #(Word("+"), ListOp(add)),
    #(Word("-"), ListOp(sub)),
    #(Word("*"), ListOp(mul)),
    #(Word("/"), ListOp(div)),
    #(Word("DUP"), ListOp(dup)),
    #(Word("DROP"), ListOp(drop)),
    #(Word("SWAP"), ListOp(swap)),
    #(Word("OVER"), ListOp(over)),
  ]
  |> map.from_list()
}

fn arity2_op(xs, f) {
  case xs {
    [Number(a), Number(b), ..rest] -> Ok([Number(f(b, a)), ..rest])
    _ -> Error(StackUnderflow)
  }
}

fn add(xs) {
  arity2_op(xs, int.add)
}

fn sub(xs) {
  arity2_op(xs, int.subtract)
}

fn mul(xs) {
  arity2_op(xs, int.multiply)
}

fn div(xs) {
  case xs {
    [Number(a), Number(b), ..rest] ->
      case int.divide(b, a) {
        Ok(result) -> Ok([Number(result), ..rest])
        Error(Nil) -> Error(DivisionByZero)
      }
    _ -> Error(StackUnderflow)
  }
}

fn dup(xs) {
  case xs {
    [x, ..rest] -> Ok([x, x, ..rest])
    _ -> Error(StackUnderflow)
  }
}

fn drop(xs) {
  case xs {
    [_, ..rest] -> Ok(rest)
    _ -> Error(StackUnderflow)
  }
}

fn swap(xs) {
  case xs {
    [a, b, ..rest] -> Ok([b, a, ..rest])
    _ -> Error(StackUnderflow)
  }
}

fn over(xs) {
  case xs {
    [b, a, ..rest] -> Ok([a, b, a, ..rest])
    _ -> Error(StackUnderflow)
  }
}
