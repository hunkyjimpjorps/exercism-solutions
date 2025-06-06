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

  @powers %{
    0 => :ohms,
    3 => :kiloohms,
    6 => :megaohms,
    9 => :gigaohms
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> Enum.map(fn c -> @colors[c] end)
    |> (fn [tens, ones, power | _] ->
          (tens * 10 + ones) * Integer.pow(10, power)
        end).()
    |> (fn
          0 -> {0, :ohms}
          r -> 
            base = 3 * floor(:math.log10(r) / 3)
            {r / (10 ** base), @powers[base]}
        end).()
  end
end
