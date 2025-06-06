defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    to_roman = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]

    check_top_digit(number, to_roman)
  end

  @spec check_top_digit(pos_integer, [{pos_integer, String.t()}]) :: String.t()
  def check_top_digit(_, []) do
    ""
  end

  def check_top_digit(number, conversion) do
    [{diff, sym} | tail] = conversion

    cond do
      number >= diff -> sym <> check_top_digit(number - diff, conversion)
      true -> check_top_digit(number, tail)
    end
  end
end
