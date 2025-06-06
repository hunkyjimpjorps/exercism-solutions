defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    divis? = &(evenly_divisible_by?(year, &1))
    divis?.(4) && (!divis?.(100) || divis?.(400))
  end

  defp evenly_divisible_by?(dividend, divisor) do
    Integer.mod(dividend, divisor) == 0
  end
end
