defmodule Allergies do
  use Bitwise
  @allergens ~w/eggs peanuts shellfish strawberries tomatoes chocolate pollen cats/

  @allergens 0..7
             |> Enum.map(fn x -> Integer.pow(2, x) end)
             |> then(&Enum.zip(@allergens, &1))
             |> Enum.into(%{})

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    for {allergen, bit} <- @allergens, (bit &&& flags) != 0, do: allergen
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item), do: (@allergens[item] &&& flags) != 0
end
