defmodule Scrabble do
  @values %{
            'AEIOULNRST' => 1,
            'DG' => 2,
            'BCMP' => 3,
            'FHVWY' => 4,
            'K' => 5,
            'JX' => 8,
            'QZ' => 10
          }
          |> Enum.flat_map(fn {ks, v} -> Enum.map(ks, fn k -> {k, v} end) end)
          |> Enum.into(%{})
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.to_charlist()
    |> Enum.reduce(0, fn c, acc -> Map.get(@values, c, 0) + acc end)
  end
end
