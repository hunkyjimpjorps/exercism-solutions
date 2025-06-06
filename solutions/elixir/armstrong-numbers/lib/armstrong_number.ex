defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """
  defp armstrong_sum(ns), do: Enum.reduce(ns, 0, fn n, acc -> acc + Integer.pow(n, length(ns)) end)

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number |> Integer.digits() |> armstrong_sum() |> (&(&1 == number)).()
  end
end
