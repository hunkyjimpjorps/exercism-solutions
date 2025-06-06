defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """

  defp transform_one_key({score, letters}) do
    Enum.into(letters, %{}, fn l -> {String.downcase(l), score} end)
  end

  @spec transform(map) :: map
  def transform(input) do
    Enum.flat_map(input, &transform_one_key/1)
    |> Enum.into(%{})
  end
end
