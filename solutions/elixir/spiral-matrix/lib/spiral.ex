defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension), do: make_spiral(1, dimension, dimension)

  defp make_spiral(_, _, 0), do: []

  defp make_spiral(start, row, col) do
    [make_line(start, col) | spin_rest(start, col, row)]
  end

  defp make_line(start, col) do
    Enum.to_list(start..(start + col - 1))
  end

  defp spin_rest(start, col, row) do
    make_spiral(start + col, col, row - 1) |> rot()
  end

  defp rot(m), do: m |> Enum.reverse() |> transpose()
  defp transpose(m), do: m |> List.zip() |> Enum.map(&Tuple.to_list/1)
end
