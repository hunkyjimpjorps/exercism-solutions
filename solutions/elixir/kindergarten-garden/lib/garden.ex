defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @students ~w/alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry/a

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    plots =
      info_string
      |> String.split()
      |> Enum.map(&(String.to_charlist(&1) |> Enum.chunk_every(2)))
      |> Enum.zip()
      |> Enum.map(&(Tuple.to_list(&1) |> Enum.join() |> to_plants()))

    unassigned_students = student_names |> Enum.into(%{}, fn n -> {n, {}} end)

    assigned_students =
      student_names
      |> Enum.sort()
      |> Enum.zip(plots)
      |> Enum.into(%{})

    Map.merge(unassigned_students, assigned_students)
  end

  defp to_plants(plot_charlist) do
    plot_charlist
    |> String.to_charlist()
    |> Enum.map(&to_plant/1)
    |> List.to_tuple()
  end

  defp to_plant(?C), do: :clover
  defp to_plant(?G), do: :grass
  defp to_plant(?R), do: :radishes
  defp to_plant(?V), do: :violets
end
