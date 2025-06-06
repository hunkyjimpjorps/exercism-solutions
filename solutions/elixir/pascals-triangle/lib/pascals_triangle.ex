defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(n) do
    for r <- 1..n, do: row(r)
  end 

  defp row(1), do: [1]
  defp row(n) do
    prev_row = row(n - 1)
    Enum.zip_with([0 | prev_row], prev_row ++ [0], &+/2)
  end
end
