defmodule BirdCount do
  def today([]), do: nil
  def today([today | _rest]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  def has_day_without_birds?(list), do: 0 in list

  def total(list), do: Enum.sum(list)

  def busy_days(list), do: Enum.filter(list, &(&1 >= 5)) |> length()
end
