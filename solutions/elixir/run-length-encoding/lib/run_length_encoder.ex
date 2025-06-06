defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(&encode_chunk/1)
    |> Enum.join()
  end

  defp encode_chunk([char]), do: char
  defp encode_chunk([char | _] = chunk), do: to_string(length(chunk)) <> char

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> (&Regex.split(~r{[0-9]*[^0-9]}, &1, include_captures: true, trim: true)).()
    |> Enum.map(&decode_chunk/1)
    |> Enum.join()
  end

  defp decode_chunk(<<c>>), do: <<c>>

  defp decode_chunk(str) do
    str
    |> String.split_at(-1)
    |> (fn {num, char} -> String.duplicate(char, String.to_integer(num)) end).()
  end
end
