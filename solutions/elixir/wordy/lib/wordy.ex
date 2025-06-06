defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(<<"What is ", rest::binary>>) do
    rest
    |> tokenize()
    |> process()
  end

  def answer(_), do: raise(ArgumentError)

  defp tokenize(str) when is_binary(str) do
    case str do
      "plus " <> rest ->
        [:add | tokenize(rest)]

      "minus " <> rest ->
        [:sub | tokenize(rest)]

      "multiplied by " <> rest ->
        [:mul | tokenize(rest)]

      "divided by " <> rest ->
        [:div | tokenize(rest)]

      _ ->
        seek_integer(str)
    end
  end

  defp seek_integer(str) do
    case String.split(str, " ", parts: 2) do
      [s, rest] ->
        with {n, _} <- Integer.parse(s),
             do: [n | tokenize(rest)],
             else: (:error -> raise ArgumentError)

      [s] ->
        with {n, _} <- Integer.parse(s),
             do: [n],
             else: (:error -> raise ArgumentError)
    end
  end

  defp process([num]) when is_number(num), do: num

  @ops %{add: &+/2, sub: &-/2, mul: &*/2, div: &//2}
  defp process([num1, op, num2 | rest])
       when is_number(num1) and is_atom(op) and is_number(num2) do
    result = @ops[op].(num1, num2)

    process([result | rest])
  end

  defp process(_), do: raise(ArgumentError)
end
