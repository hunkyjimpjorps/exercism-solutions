defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  def to_base_10(ns, base) do
    Enum.reverse(ns)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {n, i}, acc -> n * Integer.pow(base, i) + acc end)
  end

  def from_base_10(0, _), do: []
  def from_base_10(n, base), do: [Integer.mod(n, base) | from_base_10(div(n, base), base)]

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(_, input_base, _) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(ns, input_base, output_base) do
    cond do
      Enum.any?(ns, fn n -> n < 0 || n >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        to_base_10(ns, input_base)
        |> from_base_10(output_base)
        |> Enum.reverse()
        |> (fn ns -> if(Enum.empty?(ns), do: [0], else: ns) end).()
        |> (&{:ok, &1}).()
    end
  end
end