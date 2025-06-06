import gleam/list
import gleam/string

type Protein {
  Protein(String)
  StopCodon
  EndOfString
  TranslationError
}

fn translate_codon(codon: String) -> Protein {
  case codon {
    "UGU" | "UGC" -> Protein("Cysteine")
    "UUA" | "UUG" -> Protein("Leucine")
    "AUG" -> Protein("Methionine")
    "UUU" | "UUC" -> Protein("Phenylalanine")
    "UCU" | "UCC" | "UCA" | "UCG" -> Protein("Serine")
    "UGG" -> Protein("Tryptophan")
    "UAU" | "UAC" -> Protein("Tyrosine")
    "UAA" | "UAG" | "UGA" -> StopCodon
    "" -> EndOfString
    _ -> TranslationError
  }
}

fn do_parse_sequence(
  codons: String,
  into acc: List(String),
) -> Result(List(String), Nil) {
  case translate_codon(string.slice(codons, 0, 3)) {
    EndOfString | StopCodon -> Ok(list.reverse(acc))
    TranslationError -> Error(Nil)
    Protein(p) -> do_parse_sequence(string.drop_left(codons, 3), [p, ..acc])
  }
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  do_parse_sequence(rna, into: [])
}
