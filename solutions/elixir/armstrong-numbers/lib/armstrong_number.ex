defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """
  defp digits(0), do: []
  defp digits(n), do: [Integer.mod(n, 10) | digits(div(n, 10))]

  defp armstrong_sum(ns), do: Enum.reduce(ns, 0, fn n, acc -> acc + Integer.pow(n, length(ns)) end)

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number |> digits() |> armstrong_sum() |> (&(&1 == number)).()
  end
end
