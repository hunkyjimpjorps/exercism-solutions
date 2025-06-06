defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    rna |> to_codons() |> process_list([])
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    with {:ok, _} = result <- Map.fetch(@codons, codon) do
      result
    else
      :error -> {:error, "invalid codon"}
    end
  end

  defp to_codons(string) do
    string |> String.graphemes() |> Enum.chunk_every(3) |> Enum.map(&to_string/1)
  end

  defp process_list([], acc) do
    {:ok, Enum.reverse(acc)}
  end

  defp process_list([codon | rest], acc) do
    case of_codon(codon) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, Enum.reverse(acc)}
      {:ok, name} -> process_list(rest, [name | acc])
    end
  end
end
