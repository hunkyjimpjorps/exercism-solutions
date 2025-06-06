defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    all_letters = for <<c <- String.downcase(sentence)>>, c in ?a..?z, do: c
    all_letters == Enum.uniq(all_letters)
  end
end
