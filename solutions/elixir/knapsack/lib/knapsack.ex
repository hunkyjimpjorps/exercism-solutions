defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """

  @spec maximum_value(
          items :: [%{value: integer, weight: integer}],
          maximum_weight :: integer
        ) ::
          integer
  def maximum_value(items, max_weight) do
    pack_knapsack(items, %{
      current_value: 0,
      weight_remaining: max_weight
    }).current_value
  end

  defp pack_knapsack([], state), do: state

  defp pack_knapsack([%{weight: w} | rest], %{weight_remaining: r} = state)
       when w > r do
    pack_knapsack(rest, state)
  end

  defp pack_knapsack([current_item | rest], state) do
    leave_it = pack_knapsack(rest, state)

    take_it =
      pack_knapsack(rest, %{
        current_value: state.current_value + current_item.value,
        weight_remaining: state.weight_remaining - current_item.weight
      })

    if leave_it.current_value > take_it.current_value do
      leave_it
    else
      take_it
    end
  end
end
