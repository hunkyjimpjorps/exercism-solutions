defmodule BirdCount do
  def today([]), do: nil
  def today([today | _rest]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  def has_day_without_birds?(list), do: 0 in list

  def total([]), do: 0
  def total([today | rest]), do: today + total(rest)

  def busy_days([]), do: 0
  def busy_days([today | rest]) when today >= 5, do: 1 + busy_days(rest)
  def busy_days([_ | rest]), do: busy_days(rest)
end
