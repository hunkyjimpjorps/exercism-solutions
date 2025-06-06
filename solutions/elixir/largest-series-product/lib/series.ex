defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product("", _), do: raise(ArgumentError)
  def largest_product(_, size) when size < 0, do: raise(ArgumentError)

  def largest_product(number_string, size) do
    number_string
    |> String.graphemes()
    |> Enum.chunk_every(size, 1, :discard)
    |> (&if(&1 == [], do: raise(ArgumentError), else: &1)).()
    |> Enum.map(&convert_chunk/1)
    |> Enum.max()
  end

  defp convert_chunk(xs) do
    xs |> Enum.map(&String.to_integer/1) |> Enum.product()
  end
end
