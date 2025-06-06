defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode("", _), do: ""

  def encode(str, rails) do
    railposts = set_railposts(rails)
    graphemes = String.graphemes(str)

    Enum.zip(graphemes, railposts)
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Enum.map_join(fn {_, chrs} -> Enum.join(chrs) end)
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    railposts = set_railposts(rails)
    placeholders = 1..String.length(str)
    graphemes = String.graphemes(str)

    Enum.zip(placeholders, railposts)
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Map.values()
    |> Enum.concat()
    |> Enum.zip(graphemes)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map_join(&elem(&1, 1))
  end

  defp set_railposts(rails),
    do: [0..(rails - 1), (rails - 2)..1//-1] |> Stream.concat() |> Stream.cycle()
end
