defmodule ZebraPuzzle do
  alias ZebraFacts, as: Fact

  defp get_solution() do
    for col <- Fact.limit_colors(),
        nat <- Fact.limit_nationalities(col),
        tob <- Fact.limit_tobacco(col, nat),
        bev <- Fact.limit_beverage(col, nat, tob),
        pet <- Fact.limit_pet(nat, tob) do
      %{color: col, nationality: nat, tobacco: tob, beverage: bev, pet: pet}
    end
    |> List.first()
  end

  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water() do
    solution = get_solution()
    reverse_lookup(solution.nationality, solution.beverage.water)
  end

  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra() do
    solution = get_solution()
    reverse_lookup(solution.nationality, solution.pet.zebra)
  end

  defp reverse_lookup(map, key) do
    Map.new(map, fn {k, v} -> {v, k} end)[key]
  end
end
