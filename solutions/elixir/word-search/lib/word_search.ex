defmodule WordSearch do
  @directions for r <- -1..1, c <- -1..1, not (r == 0 && c == 0), do: %{r: r, c: c}

  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do
    matrix = grid_to_matrix(grid)
    for word <- words, into: %{}, do: find_word(matrix, word)
  end

  defp grid_to_matrix(grid) do
    letters =
      grid
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    for {row, r} <- Enum.with_index(letters, 1),
        {letter, c} <- Enum.with_index(row, 1),
        into: %{} do
      {%{row: r, column: c}, letter}
    end
  end

  defp find_word(matrix, word) do
    %{row: max_r, column: max_c} =
      matrix |> Map.keys() |> Enum.max_by(fn coord -> coord.row + coord.column end)

    location =
      for r <- 1..max_r,
          c <- 1..max_c,
          dir <- @directions,
          result = scan_for_word(matrix, word, %{row: r, column: c}, dir),
          result != :not_found,
          %{row: to_r, column: to_c} = result do
        %Location{from: %{row: r, column: c}, to: %{row: to_r, column: to_c}}
      end

    case location do
      [] -> {word, nil}
      [l] -> {word, l}
    end
  end

  defp scan_for_word(matrix, <<first, rest::binary>> = word, c, d) do
    case matrix[c] do
      ^word ->
        c

      <<^first>> ->
        scan_for_word(matrix, rest, %{row: c.row + d.r, column: c.column + d.c}, d)

      _ ->
        :not_found
    end
  end
end
