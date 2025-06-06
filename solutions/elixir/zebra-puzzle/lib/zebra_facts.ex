defmodule House do
  defstruct [:order, :color, :nationality, :pet, :tobacco, :beverage]
end

defmodule ZebraFacts do
  @color ~w/red green ivory yellow blue/a
  @nationality ~w/english spaniard ukrainian norwegian japanese/a
  @pet ~w/dog fox horse snails zebra/a
  @tobacco ~w/old_gold kools chesterfields lucky_strikes parliaments/a
  @beverage ~w/water tea milk orange_juice coffee/a

  @doc """
  Apply rules 6, 10 and 15:

  - The green house is immediately to the right of the ivory house.
  - The Norwegian lives in the first house.
  - The Norwegian lives next to the blue house. (i.e. the blue house is the second one)
  """
  def limit_colors() do
    @color
    |> place()
    |> Enum.filter(fn color ->
      1 + color.green == color.ivory &&
        color.blue == 1
    end)
  end

  @doc """
  Apply rules 2 and 10:

  - The Englishman lives in the red house.
  - The Norwegian lives in the first house.
  """
  def limit_nationalities(color) do
    @nationality
    |> place()
    |> Enum.filter(fn nationality ->
      nationality.english == color.red &&
        nationality.norwegian == 0
    end)
  end

  @doc """
  Applies rules 8 and 14:
  - Kools are smoked in the yellow house.
  - The Japanese smokes Parliaments.
  """
  def limit_tobacco(color, nationality) do
    @tobacco
    |> place()
    |> Enum.filter(fn tobacco ->
      tobacco.parliaments == nationality.japanese &&
        tobacco.kools == color.yellow
    end)
  end

  @doc """
  Applies rules 4, 5, 9 and 13:
  - Coffee is drunk in the green house.
  - The Ukrainian drinks tea.
  - Milk is drunk in the middle house.
  - The Lucky Strike smoker drinks orange juice.
  """
  def limit_beverage(color, nationality, tobacco) do
    @beverage
    |> place()
    |> Enum.filter(fn beverage ->
      beverage.coffee == color.green &&
        beverage.tea == nationality.ukrainian &&
        beverage.milk == 2 &&
        beverage.orange_juice == tobacco.lucky_strikes
    end)
  end

  @doc """
  Applies rules  3, 7, 11 and 12:
  - The Spaniard owns the dog.
  - The Old Gold smoker owns snails.
  - The man who smokes Chesterfields lives in the house next to the man with the fox.
  - Kools are smoked in the house next to the house where the horse is kept.
  """
  def limit_pet(nationality, tobacco) do
    @pet
    |> place()
    |> Enum.filter(fn pet ->
      pet.dog == nationality.spaniard &&
        pet.snails == tobacco.old_gold &&
        abs(pet.fox - tobacco.chesterfields) == 1 &&
        abs(pet.horse - tobacco.kools) == 1
    end)
  end

  defp permute([]), do: [[]]

  defp permute(lst) do
    for x <- lst, rest <- permute(lst -- [x]), do: [x | rest]
  end

  defp place(lst),
    do: lst |> permute |> Enum.map(fn x -> Enum.with_index(x) |> Map.new() end)
end
