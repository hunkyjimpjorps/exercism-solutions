defmodule WordCount do
  @spec count(String.t()) :: map
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  def count(words) do
    words
    |> String.downcase()
    |> String.replace(~r/[.,:;!&@$%^]/, "")
    |> String.split([" ", "_"], trim: true)
    |> Enum.frequencies()
  end
end
