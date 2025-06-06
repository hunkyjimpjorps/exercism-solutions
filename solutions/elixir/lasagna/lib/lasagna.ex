defmodule Lasagna do
  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(t) do
    expected_minutes_in_oven() - t
  end

  def preparation_time_in_minutes(l) do
    2 * l
  end

  def total_time_in_minutes(l, t) do
    preparation_time_in_minutes(l) + t
  end

  def alarm() do
    "Ding!"
  end
end
