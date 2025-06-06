defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    filtered_charlist =
      str
      |> String.downcase()
      |> (&Regex.replace(~r/[^a-z0-9]/, &1, "")).()
      |> String.graphemes()

    determine_dimensions(length(filtered_charlist), 1)
    |> chunk_it(filtered_charlist)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  defp chunk_it(len, str) do
    Enum.chunk_every(str, len, len, List.duplicate(" ", len))
  end

  defp determine_dimensions(n, c) when n <= c * (c - 1), do: c
  defp determine_dimensions(n, c) when n <= c * c, do: c
  defp determine_dimensions(n, c), do: determine_dimensions(n, c + 1)
end
