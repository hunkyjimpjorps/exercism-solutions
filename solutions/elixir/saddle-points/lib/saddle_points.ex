defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn strs -> strs |> String.split() |> Enum.map(&String.to_integer/1) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> rows_to_columns()
  end

  defp rows_to_columns(xss) do
    xss
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols = rows_to_columns(rows)

    for {r, i} <- Enum.with_index(rows, 1),
        {c, j} <- Enum.with_index(cols, 1),
        Enum.max(r) == Enum.min(c) do
      {i, j}
    end
  end
end
