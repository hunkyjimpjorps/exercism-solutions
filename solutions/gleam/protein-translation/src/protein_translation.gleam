import gleam/list
import gleam/string

type Protein {
  Protein(String)
  StopCodon
  TranslationError
}

fn translate_codon(codon: String) -> Protein {
  case codon {
    "AUG" -> Protein("Methionine")
    "UUU" | "UUC" -> Protein("Phenylalanine")
    "UUA" | "UUG" -> Protein("Leucine")
    "UCU" | "UCC" | "UCA" | "UCG" -> Protein("Serine")
    "UAU" | "UAC" -> Protein("Tyrosine")
    "UGU" | "UGC" -> Protein("Cysteine")
    "UGG" -> Protein("Tryptophan")
    "UAA" | "UAG" | "UGA" -> StopCodon
    _ -> TranslationError
  }
}

fn parse_sequence(
  codons: List(Protein),
  into acc: List(String),
) -> Result(List(String), Nil) {
  case codons {
    [] | [StopCodon, ..] -> Ok(list.reverse(acc))
    [TranslationError, ..] -> Error(Nil)
    [Protein(p), ..rest] -> parse_sequence(rest, [p, ..acc])
  }
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  rna
  |> string.to_graphemes()
  |> list.sized_chunk(into: 3)
  |> list.map(fn(chunk) {
    chunk
    |> string.concat()
    |> translate_codon()
  })
  |> parse_sequence(into: [])
}
