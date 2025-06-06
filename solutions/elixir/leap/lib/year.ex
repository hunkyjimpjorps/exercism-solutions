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
    remainders = [4, 100, 400] |> Enum.map(&(Integer.mod(year, &1)))
    case remainders do
      [_, _, 0] -> true
      [_, 0, _] -> false
      [0, _, _] -> true
      _ -> false
    end
  end
end
