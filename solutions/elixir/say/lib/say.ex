defmodule Say do
  @moduledoc false

  @positions ["", " thousand", " million", " billion"]

  @ones_digits %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  @special_tens_digits %{2 => "twenty", 3 => "thirty", 4 => "forty", 5 => "fifty", 8 => "eighty"}

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number > 999_999_999_999 or number < 0 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}

  def in_english(number) do
    group_by_thousands(number)
    |> Enum.map(&parse_chunk/1)
    |> Enum.zip(@positions)
    |> Enum.reverse()
    |> Enum.reject(fn {word, _} -> word == "" end)
    |> Enum.map_join(" ", &Tuple.to_list/1)
    |> (&{:ok, &1}).()
  end

  defp tens_digit_name(n) do
    Map.get(@special_tens_digits, n, @ones_digits[n] <> "ty")
  end

  defp group_by_thousands(number) do
    Integer.digits(number)
    |> Enum.reverse()
    |> Enum.chunk_every(3, 3, [0, 0, 0])
    |> Enum.map(&Enum.reverse/1)
  end

  defp parse_chunk([h, t, o]) do
    (parse_hundreds(h) <> " " <> parse_tens_and_ones(t, o))
    |> String.trim()
  end

  defp parse_hundreds(h), do: @ones_digits[h] <> " " <> "hundred"

  defp parse_tens_and_ones(1, o) do
    case o do
      0 -> "ten"
      1 -> "eleven"
      2 -> "twelve"
      3 -> "thirteen"
      n -> @ones_digits[n] <> "teen"
    end
  end

  defp parse_tens_and_ones(0, o), do: @ones_digits[o]
  defp parse_tens_and_ones(t, 0), do: tens_digit_name(t)
  defp parse_tens_and_ones(t, o), do: tens_digit_name(t) <> "-" <> @ones_digits[o]
end
