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
        matrix[pt(p1.r, p2.c)] == ?+,
        matrix[pt(p2.r, p1.c)] == ?+,
        all_connected?(matrix, p1, p2),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  defp string_to_matrix(str) do
    for {row, r} <- Enum.with_index(String.split(str, "\n")),
        {char, c} <- Enum.with_index(String.to_charlist(row)),
        into: %{} do
      {pt(r, c), char}
    end
  end

  defp all_connected?(m, p1, p2) do
    Enum.all?([
      Enum.all?(p1.r..p2.r, &(m[pt(&1, p1.c)] in '+|')),
      Enum.all?(p1.r..p2.r, &(m[pt(&1, p2.c)] in '+|')),
      Enum.all?(p1.c..p2.c, &(m[pt(p1.r, &1)] in '+-')),
      Enum.all?(p1.c..p2.c, &(m[pt(p2.r, &1)] in '+-'))
    ])
  end

  defp pt(r, c), do: %{r: r, c: c}
end
