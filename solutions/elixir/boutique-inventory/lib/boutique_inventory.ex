defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1[:price])
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1[:price]))
  end

  def increase_quantity(item, count) do
    %{
      item
      | quantity_by_size:
          Enum.into(item[:quantity_by_size], %{}, fn {key, val} -> {key, val + count} end)
    }
  end

  def total_quantity(item) do
    Enum.reduce(item[:quantity_by_size], 0, fn {key, val}, acc -> val + acc end)
  end
end