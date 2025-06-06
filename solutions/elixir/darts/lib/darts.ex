defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    case Float.pow((x * x + y * y)/1, 0.5) do
      n when n <= 1 -> 10
      n when n <= 5 -> 5
      n when n <= 10 -> 1
      _ -> 0
    end
  end
end
