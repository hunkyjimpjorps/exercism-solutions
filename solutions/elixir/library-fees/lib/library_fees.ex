defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    Time.compare(datetime, ~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(if before_noon?(checkout_datetime), do: 28, else: 29)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    monday_discount = if monday?(datetime_from_string(return)), do: 0.5, else: 1.0

    days_late =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(datetime_from_string(return))

    floor(rate * days_late * monday_discount)
  end
end
