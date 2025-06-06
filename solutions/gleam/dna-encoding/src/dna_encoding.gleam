import gleam/list

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

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  list.fold(
    over: dna,
    from: <<>>,
    with: fn(acc, base) { <<acc:bits, encode_nucleotide(base):2>> },
  )
}

fn bit_string_to_nucleotide_list(
  bs: BitArray,
  base: Int,
  acc: List(Nucleotide),
) -> Result(List(Nucleotide), Nil) {
  case bs {
    <<>> -> Ok(list.reverse(acc))
    <<head:size(base), rest:bits>> -> {
      let assert Ok(b) = decode_nucleotide(head)
      bit_string_to_nucleotide_list(rest, base, list.prepend(acc, this: b))
    }
    _ -> Error(Nil)
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  bit_string_to_nucleotide_list(dna, 2, [])
}
