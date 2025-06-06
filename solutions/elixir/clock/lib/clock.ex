defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    hour = rem_e(rem_e(hour, 24) + div_e(minute, 60), 24)
    minute = rem_e(minute, 60)
    %Clock{hour: hour, minute: minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end

  # Euclidean division and remainder to properly handle negative dividends
  defp div_e(a, n) do
    div(abs(n), n) * floor(a / abs(n))
  end
  defp rem_e(a, n) do
    a - abs(n) * floor(a / abs(n))
  end

  defimpl String.Chars, for: Clock do
    def to_string(clock) do
      "#{format_part(clock.hour)}:#{format_part(clock.minute)}"
    end

    defp format_part(n) do
      n
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end
  end 
end
