defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @pad "\u{0000}"

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    original = String.split(input, "\n")

    cols =
      original
      |> Enum.map(&String.length/1)
      |> Enum.max()

    original
    |> Enum.map(&(String.pad_trailing(&1, cols, @pad) |> String.graphemes()))
    |> Enum.zip()
    |> Enum.map(
      &(Tuple.to_list(&1)
        |> Enum.join()
        |> String.trim_trailing(@pad)
        |> String.replace(@pad, " "))
    )
    |> Enum.join("\n")
    |> String.trim_trailing(" ")
  end
end
