defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts) do
    colors = MapSet.new(Keyword.keys(opts))
    if not MapSet.subset?(colors, MapSet.new([:black, :white])), do: raise(ArgumentError)

    new = struct(Queens, opts)

    cond do
      new.black == new.white -> raise ArgumentError
      outside_board?(new.black) or outside_board?(new.white) -> raise ArgumentError
      true -> new
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for row <- 0..7 do
      for col <- 0..7 do
        cell = {row, col}

        cond do
          cell == queens.black -> "B"
          cell == queens.white -> "W"
          true -> "_"
        end
      end
    end
    |> Enum.map_join("\n", &Enum.join(&1, " "))
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {r, _}, white: {r, _}}), do: true
  def can_attack?(%Queens{black: {_, c}, white: {_, c}}), do: true

  def can_attack?(%Queens{black: {r1, c1}, white: {r2, c2}}) when abs(r1 - r2) == abs(c1 - c2),
    do: true

  def can_attack?(_), do: false

  defp outside_board?({x, y}) when x in 0..7 and y in 0..7, do: false
  defp outside_board?(nil), do: false
  defp outside_board?(_), do: true
end
