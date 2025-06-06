defmodule Tournament do
  @moduledoc false
  defstruct points: 0, wins: 0, losses: 0, draws: 0, matches: 0

  @scoring %{wins: 3, losses: 0, draws: 1}

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    Enum.map(input, &String.split(&1, ";"))
    |> parse_next_game(Map.new())
    |> Map.to_list()
    |> sort_map()
    |> Enum.map(&format_line/1)
    |> print_report()
  end

  defp parse_next_game([], acc), do: acc

  defp parse_next_game([[first_team, second_team, "win"] | rest], acc) do
    team_won(acc, first_team)
    |> team_lost(second_team)
    |> (&parse_next_game(rest, &1)).()
  end

  defp parse_next_game([[first_team, second_team, "loss"] | rest], acc) do
    team_lost(acc, first_team)
    |> team_won(second_team)
    |> (&parse_next_game(rest, &1)).()
  end

  defp parse_next_game([[first_team, second_team, "draw"] | rest], acc) do
    team_tied(acc, first_team)
    |> team_tied(second_team)
    |> (&parse_next_game(rest, &1)).()
  end

  defp parse_next_game([_invalid | rest], acc), do: parse_next_game(rest, acc)

  defp team_won(acc, team_name), do: update_team_map(acc, team_name, :wins)
  defp team_lost(acc, team_name), do: update_team_map(acc, team_name, :losses)
  defp team_tied(acc, team_name), do: update_team_map(acc, team_name, :draws)

  defp update_team_map(acc, team_name, result) do
    Map.update(
      acc,
      team_name,
      %{%Tournament{} | result => 1, :matches => 1, :points => @scoring[result]},
      fn team ->
        Map.update!(team, result, &(&1 + 1))
        |> Map.update!(:matches, &(&1 + 1))
        |> Map.update!(:points, &(&1 + @scoring[result]))
      end
    )
  end

  defp sort_map(acc) do
    acc
    |> Enum.sort_by(&elem(&1, 0), :asc)
    |> Enum.sort_by(&elem(&1, 1).points, :desc)
  end

  defp format_line({team, %Tournament{matches: mp, wins: w, draws: d, losses: l, points: p}}) do
    [mp, w, d, l, p]
    |> Enum.map(fn n -> Integer.to_string(n) |> String.pad_leading(2) end)
    |> (&[String.pad_trailing(team, 30) | &1]).()
    |> Enum.join(" | ")
  end

  defp print_report(acc) do
    ["Team                           | MP |  W |  D |  L |  P" | acc]
    |> Enum.join("\n")
  end
end
