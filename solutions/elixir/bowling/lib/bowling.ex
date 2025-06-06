defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  defstruct score: 0,
            bonus: nil,
            current_frame: 1,
            current_roll: :first,
            first_roll: nil,
            remaining_pins: 10,
            previous_two_rolls: [nil, nil]

  @type score_or_nil :: non_neg_integer() | nil
  @type t :: %__MODULE__{
          score: non_neg_integer(),
          bonus: score_or_nil(),
          current_frame: non_neg_integer(),
          current_roll: :first | :second,
          first_roll: score_or_nil(),
          previous_two_rolls: [atom()],
          remaining_pins: non_neg_integer()
        }

  @too %{
    many: "Pin count exceeds pins on the lane",
    few: "Negative roll is invalid",
    soon: "Score cannot be taken until the end of the game",
    late: "Cannot roll after game is over"
  }

  @spec start() :: any
  def start, do: %__MODULE__{}

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(t(), integer) :: {:ok, any} | {:error, String.t()}
  def roll(_, roll) when roll > 10, do: {:error, @too.many}
  def roll(_, roll) when roll < 0, do: {:error, @too.few}
  def roll(%Bowling{bonus: 0}, _), do: {:error, @too.late}
  def roll(%Bowling{current_frame: 11, bonus: nil}, _), do: {:error, @too.late}
  def roll(%Bowling{current_frame: frame}, _) when frame > 11, do: {:error, @too.late}
  def roll(%Bowling{remaining_pins: p}, roll) when p < roll, do: {:error, @too.many}

  def roll(%Bowling{} = game, roll) do
    updated_game =
      case {game.current_roll, roll} do
        {:first, 10} -> update_current_frame(game, :strike)
        r -> update_current_frame(game, r)
      end

    {:ok, updated_game}
  end

  defp update_current_frame(
         %Bowling{current_frame: c, score: s, previous_two_rolls: ps} = game,
         :strike
       ) do
    bonus_status = c == 10

    %Bowling{
      game
      | current_frame: c + 1,
        current_roll: if(bonus_status, do: :bonus, else: :first),
        score: s + calculate_bonuses(game) * 10,
        bonus: if(bonus_status, do: 2, else: nil),
        previous_two_rolls: Enum.take([:strike | ps], 2)
    }
  end

  defp update_current_frame(%Bowling{score: s, previous_two_rolls: ps} = game, {:first, roll}) do
    %Bowling{
      game
      | score: s + calculate_bonuses(game) * roll,
        current_roll: :second,
        first_roll: roll,
        previous_two_rolls: Enum.take([:nothing | ps], 2),
        remaining_pins: 10 - roll
    }
  end

  defp update_current_frame(
         %Bowling{current_frame: c, first_roll: f, score: s, previous_two_rolls: ps} = game,
         {:second, roll}
       ) do
    bonus_status = c == 10 && f + roll == 10
    spare_or_nothing = if(f + roll == 10, do: :spare, else: :nothing)

    %Bowling{
      game
      | score: s + calculate_bonuses(game) * roll,
        current_frame: c + 1,
        current_roll: if(bonus_status, do: :bonus, else: :first),
        first_roll: nil,
        previous_two_rolls: Enum.take([spare_or_nothing | ps], 2),
        bonus: if(bonus_status, do: 1, else: nil),
        remaining_pins: 10
    }
  end

  defp update_current_frame(%Bowling{score: s, bonus: b} = game, {:bonus, roll}) do
    %Bowling{
      game
      | score: s + roll,
        bonus: b - 1,
        remaining_pins: if(roll == 10, do: 10, else: 10 - roll)
    }
  end

  defp calculate_bonuses(%Bowling{previous_two_rolls: ps}) do
    case ps do
      [:strike, :strike] -> 3
      [:spare, :strike] -> 3
      [:strike, _] -> 2
      [:spare, _] -> 2
      _ -> 1
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(t()) :: {:ok, integer} | {:error, String.t()}
  def score(%{bonus: b}) when is_integer(b) and b > 0, do: {:error, @too.soon}
  def score(%{current_frame: f, score: s}) when f in [11, 12], do: {:ok, s}
  def score(%{current_frame: f}) when f <= 10, do: {:error, @too.soon}
end
