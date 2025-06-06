defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate([]), do: []
  def annotate([""]), do: [""]

  def annotate(board) do
    mine_positions = get_mine_positions(board)
    cols = String.length(hd(board))

    for pos <- Map.keys(mine_positions) |> Enum.sort(),
        cell = Map.get(mine_positions, pos, " ") do
      case cell do
        "*" ->
          "*"

        " " ->
          adjacent_cells(pos)
          |> Enum.map(&Map.get(mine_positions, &1))
          |> Enum.count(&(&1 == "*"))
          |> then(&if &1 == 0, do: " ", else: &1)
      end
    end
    |> Enum.chunk_every(cols)
    |> Enum.map(&Enum.join/1)
  end

  defp get_mine_positions(board) do
    for {row, i} <- Enum.with_index(board),
        {cell, j} <- Enum.with_index(String.codepoints(row)),
        into: %{} do
      {{i, j}, cell}
    end
  end

  defp adjacent_cells({i, j}) do
    for delta_i <- -1..1,
        delta_j <- -1..1,
        {delta_i, delta_j} != {0, 0} do
      {i + delta_i, j + delta_j}
    end
  end
end
