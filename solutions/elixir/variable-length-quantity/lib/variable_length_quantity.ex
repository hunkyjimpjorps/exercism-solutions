defmodule VariableLengthQuantity do
  use Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    for i <- integers, reduce: <<>> do
      acc ->
        case i do
          0 -> acc <> <<0>>
          x -> acc <> encode_int(x, 0, <<>>)
        end
    end
  end

  defp encode_int(0, _, acc), do: acc
  defp encode_int(x, b, acc), do: encode_int(x >>> 7, 1, <<b::1, x::7, acc::binary>>)

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes, register \\ 0, acc \\ [])

  def decode(<<>>, _, acc), do: {:ok, Enum.reverse(acc)}
  def decode(<<1::1, _::7, <<>>::binary>>, _, _), do: {:error, "incomplete sequence"}
  def decode(<<0::1, i::7, rest::binary>>, r, a), do: decode(rest, 0, [i ||| r <<< 7 | a])
  def decode(<<1::1, i::7, rest::binary>>, r, a), do: decode(rest, i ||| r <<< 7, a)
end
