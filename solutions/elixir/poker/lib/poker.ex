defmodule Poker do
  import PokerHands

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand([singleton]), do: [singleton]

  def best_hand(hands) do
    winning_hand = Enum.max_by(hands, &identify_hand/1, &compare_hands/2)

    Enum.filter(hands, fn h -> identify_hand(winning_hand) == identify_hand(h) end)
  end

  @hands %{
    straight_flush: 9,
    four_of_a_kind: 8,
    full_house: 7,
    flush: 6,
    straight: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1
  }

  defp identify_hand(hand) do
    hand = Enum.map(hand, &parse_card/1)

    classify_as =
      cond do
        straight?(hand) && flush?(hand) -> :straight_flush
        n_of_a_kind?(hand, 4) -> :four_of_a_kind
        n_of_a_kind?(hand, 3) && n_of_a_kind?(hand, 2) -> :full_house
        flush?(hand) -> :flush
        straight?(hand) -> :straight
        n_of_a_kind?(hand, 3) -> :three_of_a_kind
        two_pair?(hand) -> :two_pair
        n_of_a_kind?(hand, 2) -> :one_pair
        true -> :high_card
      end

    {classify_as, tiebreakers(hand)}
  end

  defp parse_card(<<"10", suit>>) do
    {10, suit}
  end

  @values %{?A => 14, ?K => 13, ?Q => 12, ?J => 11}

  defp parse_card(<<value, suit>>) do
    with {n, _} <- Integer.parse(<<value>>) do
      {n, suit}
    else
      _ -> {@values[value], suit}
    end
  end

  defp compare_hands({type1, _}, {type2, _}) when type1 != type2 do
    @hands[type1] >= @hands[type2]
  end

  defp compare_hands({type, []}, {type, []}), do: true

  defp compare_hands({type, [a | rest_a]}, {type, [b | rest_b]}) do
    if a == b do
      compare_hands({type, rest_a}, {type, rest_b})
    else
      a >= b
    end
  end
end
