defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade) do
    with {_, db} <- Map.get_and_update(db, grade, &check_dupes_and_add(db, name, &1)), do: db
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    db
    |> Enum.map(fn {k, v} -> {k, Enum.sort(v)} end)
    |> Enum.sort_by(fn {k, _} -> k end)
  end

  defp all_students(db) do
    db
    |> Map.values()
    |> Enum.concat()
  end

  defp check_dupes_and_add(db, name, current_value) do
    current_value = if is_nil(current_value), do: [], else: current_value

    cond do
      name in current_value -> {current_value, current_value}
      name in all_students(db) -> :pop
      true -> {current_value, [name | current_value]}
    end
  end
end
