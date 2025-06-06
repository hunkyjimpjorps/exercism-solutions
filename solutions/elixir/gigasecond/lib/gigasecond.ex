defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    with {:ok, date} <- Date.new(year, month, day),
         {:ok, time} <- Time.new(hours, minutes, seconds),
         {:ok, datetime} <- DateTime.new(date, time),
         future <- DateTime.add(datetime, 1_000_000_000) do
      {{future.year, future.month, future.day}, {future.hour, future.minute, future.second}}
    end
  end
end
