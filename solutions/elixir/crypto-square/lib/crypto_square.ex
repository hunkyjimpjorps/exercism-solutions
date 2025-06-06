defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    filtered_str =
      str
      |> String.downcase()
      |> (&Regex.replace(~r/[^a-z0-9]/, &1, "")).()
      |> String.graphemes()

    {row, _} = determine_dimensions(length(filtered_str), 1)

    Enum.chunk_every(
      filtered_str,
      row,
      row,
      List.duplicate(" ", row)
    )
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  defp determine_dimensions(n, c) when n <= c * (c - 1), do: {c, c - 1}
  defp determine_dimensions(n, c) when n <= c * c, do: {c, c}
  defp determine_dimensions(n, c), do: determine_dimensions(n, c + 1)
end
