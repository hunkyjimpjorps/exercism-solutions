defmodule ResistorColorDuo do
  @colors %{black: 0, brown: 1, red: 2, orange: 3, yellow: 4, green: 5, blue: 6, violet: 7, grey: 8, white: 9}
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([tens, ones | _rest]) do
    @colors[tens] * 10 + @colors[ones]
  end
end
