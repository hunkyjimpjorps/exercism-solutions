defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{String.capitalize(zero?(number))} #{plural(number)} of beer on the wall, #{zero?(number)} #{plural(number)} of beer.
    #{exhortation(number)}
    """
  end

  defp zero?(0), do: "no more"
  defp zero?(number), do: Integer.to_string(number)

  defp plural(1), do: "bottle"
  defp plural(_), do: "bottles"

  defp exhortation(0), do: "Go to the store and buy some more, 99 bottles of beer on the wall."
  defp exhortation(number) do
    now = number - 1
    "Take #{it_or_one(number)} down and pass it around, #{zero?(now)} #{plural(now)} of beer on the wall."
  end

  defp it_or_one(1), do: "it"
  defp it_or_one(_), do: "one"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
