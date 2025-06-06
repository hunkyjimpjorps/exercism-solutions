defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: do_factors(number, 2, [])

  def do_factors(1, _, factors), do: Enum.reverse(factors)

  def do_factors(number, divisor, factors) do
    if rem(number, divisor) == 0 do
      do_factors(
        div(number, divisor),
        divisor,
        [divisor | factors]
      )
    else
      do_factors(
        number,
        divisor + 1,
        factors
      )
    end
  end
end
