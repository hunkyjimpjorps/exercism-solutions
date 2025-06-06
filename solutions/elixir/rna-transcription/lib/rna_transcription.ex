defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  def to_rna([head | tail]) do
    [translate_base(head) | to_rna(tail)]
  end

  def to_rna([]) do
    []
  end

  def translate_base(base) do
    case base do
      ?A -> ?U
      ?C -> ?G
      ?T -> ?A
      ?G -> ?C
    end
  end
end
