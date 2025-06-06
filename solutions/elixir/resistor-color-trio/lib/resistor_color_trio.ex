defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """

  @colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    colors
    |> Enum.map(fn c -> @colors[c] end)
    |> compute()
    |> (fn
          r when r > 1000 -> {r / 1000, :kiloohms}
          r -> {r, :ohms}
        end).()
  end

  defp compute([tens, ones, power]) do
    (tens * 10 + ones) * Integer.pow(10, power)
  end
end
