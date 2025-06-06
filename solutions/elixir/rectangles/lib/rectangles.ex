defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    matrix = string_to_matrix(input)

    vertices = for {coord, char} <- matrix, char == ?+, do: coord

    for p1 <- vertices,
        p2 <- vertices,
        p2.r > p1.r and p1.c > p2.c,
        matrix[%{r: p1.r, c: p2.c}] == ?+,
        matrix[%{r: p2.r, c: p1.c}] == ?+,
        all_connected?(matrix, p1, p2),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  defp string_to_matrix(str) do
    for {row, r} <- Enum.with_index(String.split(str, "\n")),
        {char, c} <- Enum.with_index(String.to_charlist(row)),
        into: %{} do
      {%{r: r, c: c}, char}
    end
  end

  defp all_connected?(matrix, p1, p2) do
    Enum.all?([
      Enum.all?(p1.r..p2.r, &(matrix[%{r: &1, c: p1.c}] in '+|')),
      Enum.all?(p1.r..p2.r, &(matrix[%{r: &1, c: p2.c}] in '+|')),
      Enum.all?(p1.c..p2.c, &(matrix[%{r: p1.r, c: &1}] in '+-')),
      Enum.all?(p1.c..p2.c, &(matrix[%{r: p2.r, c: &1}] in '+-'))
    ])
  end
end
