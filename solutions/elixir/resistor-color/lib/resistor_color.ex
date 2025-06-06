defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """
  @color_table %{
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

  @spec code(atom) :: integer()
  def code(color) do
    @color_table[color]
  end
end
