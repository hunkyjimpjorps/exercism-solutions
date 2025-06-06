defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from(erl_datetime) do
    with {:ok, start} <- NaiveDateTime.from_erl(erl_datetime),
         future <- NaiveDateTime.add(start, 1_000_000_000),
         erl_future <- NaiveDateTime.to_erl(future),
         do: erl_future
  end
end
