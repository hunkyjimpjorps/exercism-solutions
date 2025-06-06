defmodule PokerHands do
  def straight?(hand) do
    ranks = ranks(hand)

    ranks == [14, 5, 4, 3, 2] ||
      (Enum.max(ranks) - Enum.min(ranks) == 4 && Enum.uniq(ranks) == ranks)
  end

  def flush?(hand), do: length(suits(hand)) == 1

  def two_pair?(hand) do
    [1, 2, 2] == hand |> ranks |> Enum.frequencies() |> Map.values() |> Enum.sort()
  end

  @spec n_of_a_kind?(any, any) :: boolean
  def n_of_a_kind?(hand, n) do
    n in (hand |> ranks |> Enum.frequencies() |> Map.values())
  end

  defp ranks(hand), do: hand |> Enum.map(&elem(&1, 0)) |> Enum.sort(:desc)
  defp suits(hand), do: hand |> Enum.map(&elem(&1, 1)) |> Enum.uniq()

  def tiebreakers(hand) do
    if ranks(hand) == [14, 5, 4, 3, 2] do
      [5, 4, 3, 2, 1]
    else
      ranks(hand)
      |> Enum.chunk_by(& &1)
      |> Enum.sort_by(&length/1, :desc)
      |> List.flatten()
    end
  end
end
