defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number, divisor \\ 2, factors \\ [])

  def factors_for(1, _, factors), do: Enum.reverse(factors)

  def factors_for(number, divisor, factors) do
    if rem(number, divisor) == 0 do
      factors_for(
        div(number, divisor),
        divisor,
        [divisor | factors]
      )
    else
      factors_for(
        number,
        divisor + 1,
        factors
      )
    end
  end
end
