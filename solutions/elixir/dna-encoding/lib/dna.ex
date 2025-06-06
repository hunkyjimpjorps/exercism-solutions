defmodule DNA do
  @base_to_code %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }

  @code_to_base Enum.map(@base_to_code, fn {k, v} -> {v, k} end) |> Enum.into(%{})

  def encode_nucleotide(code_point) do
    Map.get(@base_to_code, code_point)
  end

  def decode_nucleotide(encoded_code) do
    Map.get(@code_to_base, encoded_code)
  end

  def encode(dna), do: do_encode(dna, <<0::size(0)>>)

  defp do_encode([], acc), do: acc

  defp do_encode([h | t], acc) do
    do_encode(t, <<acc::bitstring, encode_nucleotide(h)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<0::0>>, acc), do: Enum.reverse(acc)

  defp do_decode(<<h::4, t::bitstring>>, acc) do
    do_decode(t, [decode_nucleotide(h) | acc])
  end
end
