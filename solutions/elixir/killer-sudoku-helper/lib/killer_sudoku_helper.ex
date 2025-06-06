defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) do
    Enum.to_list(1..9) -- exclude
    |> Combination.combine(size)
    |> Enum.map(&Enum.sort/1)
    |> Enum.sort_by(&hd/1)
    |> Enum.filter(&(Enum.sum(&1) == sum))
  end
end
