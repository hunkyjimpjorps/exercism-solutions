import gleam/bit_string
import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitString {
  list.fold(
    over: dna,
    from: <<>>,
    with: fn(acc, base) { <<acc:bit_string, encode_nucleotide(base):2>> },
  )
}

fn bit_string_to_int_list(
  bs: BitString,
  base: Int,
  acc: Result(List(Int), Nil),
) -> Result(List(Int), Nil) {
  case bs {
    <<>> -> result.map(acc, list.reverse)
    <<head:size(base), rest:bit_string>> ->
      bit_string_to_int_list(
        rest,
        base,
        result.map(acc, list.prepend(to: _, this: head)),
      )
    _ -> Error(Nil)
  }
}

pub fn decode(dna: BitString) -> Result(List(Nucleotide), Nil) {
  let is = bit_string_to_int_list(dna, 2, Ok([]))
  use xs <- result.map(is)
  use x <- list.map(xs)
  let assert Ok(b) = decode_nucleotide(x)
  b
}
