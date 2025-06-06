defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = Regex.replace(~r/[\s]/, number, "")

    cond do
      Regex.match?(~r/[^0-9]/, number) -> false
      String.length(number) < 2 -> false
      rem(luhn_sum(number), 10) == 0 -> true
      true -> false
    end
  end

  defp luhn_sum(xs) do
    xs
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(&modify_digit/1)
    |> Enum.sum()
  end

  defp modify_digit({digit, index}) when rem(index, 2) == 1 do
    if digit >= 5, do: 2 * digit - 9, else: 2 * digit
  end

  defp modify_digit({digit, _}), do: digit
end
