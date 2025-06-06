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
    chunk_length = ceil(Enum.count(letters) / workers)

    letters
    |> Enum.chunk_every(chunk_length)
    |> Enum.map(&Task.async(fn -> Enum.frequencies(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.reduce(&Map.merge(&1, &2, fn _, v1, v2 -> v1 + v2 end))
  end
end
