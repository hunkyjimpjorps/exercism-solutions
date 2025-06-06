defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @week_ranges %{
    first: 1..7,
    second: 8..14,
    third: 15..21,
    fourth: 22..28,
    teenth: 13..19
  }

  @weekday_index %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    with {:ok, day_one} <- Date.new(year, month, 1),
         days <- make_day_list(day_one, schedule) do
      Enum.find(days, &(Date.day_of_week(&1) == @weekday_index[weekday]))
    end
  end

  defp make_day_list(%{year: year, month: month} = date, :last) do
    len = Date.days_in_month(date)
    (len - 6)..len
    |> Enum.map(&Date.new!(year, month, &1))
  end

  defp make_day_list(%{year: year, month: month}, schedule) do
    @week_ranges[schedule]
    |> Enum.map(&Date.new!(year, month, &1))
  end
end
