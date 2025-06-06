defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1, _), do: []

  def factors_for(number, divisor \\ 2) do
    if rem(number, divisor) == 0 do
      [divisor | factors_for(div(number, divisor), divisor)]
    else
      factors_for(number, divisor + 1)
    end
  end
end