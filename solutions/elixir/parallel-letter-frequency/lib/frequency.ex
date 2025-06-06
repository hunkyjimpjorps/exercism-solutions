defmodule Frequency do
  @moduledoc false
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.join()
    |> String.downcase()
    |> String.replace(~r/[^[:alpha:]]/u, "")
    |> String.graphemes()
    |> parallel_freq(workers)
  end

  defp parallel_freq([], _), do: %{}

  defp parallel_freq(letters, workers) do
    letters
    |> Enum.chunk_every(ceil(Enum.count(letters) / workers))
    |> Task.async_stream(&Enum.frequencies/1)
    |> Enum.reduce(%{}, &merge_async_results/2)
  end

  defp merge_async_results({:ok, map}, acc) do
    Map.merge(map, acc, fn _, a, b -> a + b end)
  end
end
