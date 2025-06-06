defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @matches %{ones: 1, twos: 2, threes: 3, fours: 4, fives: 5, sixes: 6}
  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:yacht, dice) do
    case dice do
      [d, d, d, d, d] -> 10 * d
      _ -> 0
    end
  end

  def score(match, dice) when match in [:ones, :twos, :threes, :fours, :fives, :sixes] do
    pips = @matches[match]

    Enum.count(dice, fn d -> d == pips end)
    |> Kernel.*(pips)
  end

  def score(:choice, dice) do
    Enum.sum(dice)
  end

  def score(:full_house, dice) do
    with freqs <- Enum.frequencies(dice),
         map <- Enum.into(freqs, %{}, fn {k, v} -> {v, k} end),
         %{2 => a, 3 => b} <- map do
      2 * a + 3 * b
    else
      _ -> 0
    end
  end

  def score(:four_of_a_kind, dice) do
    with freqs <- Enum.frequencies(dice),
         map <- Enum.into(freqs, %{}, fn {k, v} -> {v, k} end),
         %{4 => d} <- map do
      4 * d
    else
      %{5 => d} -> 4 * d
      _ -> 0
    end
  end

  def score(:little_straight, dice) do
    if Enum.sort(dice) == [1, 2, 3, 4, 5], do: 30, else: 0
  end

  def score(:big_straight, dice) do
    if Enum.sort(dice) == [2, 3, 4, 5, 6], do: 30, else: 0
  end
end
