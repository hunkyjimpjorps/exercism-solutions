defmodule StateOfTicTacToe do
  defguard is_move(space) when space in ["X", "O"]

  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    with spaces <- tokenize_board(board),
         x_wins <- find_win(spaces, "X"),
         o_wins <- find_win(spaces, "O"),
         :ok <- validate_board(spaces) do
      {x_game_state, _winner} = x_wins
      {o_game_state, _winner} = o_wins
      game_state = if x_game_state == :win || o_game_state == :win, do: :win, else: x_game_state
      {:ok, game_state}
    end
  end

  defp tokenize_board(board) do
    String.split(board, "\n")
    |> Enum.flat_map(&String.graphemes/1)
  end

  defp validate_board(spaces) do
    freqs =
      Enum.frequencies(spaces)
      |> then(&Map.merge(%{"X" => 0, "O" => 0}, &1))

    cond do
      freqs["O"] > freqs["X"] ->
        {:error, "Wrong turn order: O started"}

      freqs["X"] - freqs["O"] >= 2 ->
        {:error, "Wrong turn order: X went twice"}

      find_win(spaces, "X") == {:win, "X"} &&
        find_win(spaces, "O") == {:win, "O"} &&
          freqs["O"] - freqs["X"] <= 0 ->
        {:error, "Impossible board: game should have ended after the game was won"}

      true ->
        :ok
    end
  end

  defp find_win(spaces, x) do
    case spaces do
      [^x, ^x, ^x, _, _, _, _, _, _] -> {:win, x}
      [_, _, _, ^x, ^x, ^x, _, _, _] -> {:win, x}
      [_, _, _, _, _, _, ^x, ^x, ^x] -> {:win, x}
      [^x, _, _, ^x, _, _, ^x, _, _] -> {:win, x}
      [_, ^x, _, _, ^x, _, _, ^x, _] -> {:win, x}
      [_, _, ^x, _, _, ^x, _, _, ^x] -> {:win, x}
      [^x, _, _, _, ^x, _, _, _, ^x] -> {:win, x}
      [_, _, ^x, _, ^x, _, ^x, _, _] -> {:win, x}
      xs -> if Enum.all?(xs, &is_move/1), do: {:draw, :no_winner}, else: {:ongoing, :no_winner}
    end
  end
end
