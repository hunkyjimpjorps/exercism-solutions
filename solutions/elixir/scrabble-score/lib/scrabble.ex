defmodule Scrabble do
  @values for {cs, p} <- %{
                'AEIOULNRST' => 1,
                'DG' => 2,
                'BCMP' => 3,
                'FHVWY' => 4,
                'K' => 5,
                'JX' => 8,
                'QZ' => 10
              },
              c <- cs,
              into: %{},
              do: {c, p}
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
