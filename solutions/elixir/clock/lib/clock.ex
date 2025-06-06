defmodule Clock do
  defstruct hour: 0, minute: 0
  @doc """
  Returns a clock that can be represented as a string:
 
      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    # do_new(hour, minute)
    {hour, minute} = convert_to_mins(hour, minute) |> convert_mins_to_time()
    %Clock{hour: hour, minute: minute}
  end
  defp convert_to_mins(hour, minute) do
    hour * 60 + minute
  end
  defp convert_mins_to_time(minutes) do
    {hours, minutes} = div_with_rem(minutes, 60)
    {_days, hour} = div_with_rem(hours, 24)
    case minutes >= 0 do
      true -> {rem(24 + hour, 24), minutes}
      false -> {rem(24 + (hour - 1), 24), 60 + minutes}
    end
  end
  defp div_with_rem(dividend, divisor) do
    {div(dividend, divisor), rem(dividend, divisor)}
  end
  defimpl String.Chars, for: Clock do
    def to_string(%Clock{} = clock) do
      "#{pad(clock.hour)}:#{pad(clock.minute)}"
    end
    defp pad(integer) do
      integer
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end
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
end