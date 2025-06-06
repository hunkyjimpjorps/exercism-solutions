defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @alphabet ?a..?z
  @alpha_length Enum.count(@alphabet)
  @alpha_to_index [@alphabet, 0..@alpha_length] |> Enum.zip() |> Enum.into(%{})
  @index_to_alpha Enum.into(@alpha_to_index, %{}, fn {k, v} -> {v, k} end)

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if Integer.gcd(a, @alpha_length) != 1 do
      {:error, "a and m must be coprime."}
    else
      message
      |> String.replace(~r/[^[:alnum:]]/, "")
      |> String.downcase()
      |> then(&for <<c <- &1>>, do: <<encode_letter(a, b, c)>>)
      |> Enum.chunk_every(5)
      |> Enum.map_join(&Enum.join/1)
      |> ok()
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    {gcd, inv_a, _} = Integer.extended_gcd(a, @alpha_length)

    if gcd != 1 do
      {:error, "a and m must be coprime."}
    else
      encrypted
      |> String.replace(~r/[^[:alnum:]]/, "")
      |> then(&for <<c <- &1>>, into: "", do: <<decode_letter(inv_a, b, c)>>)
      |> ok()
    end
  end

  defp encode_letter(a, b, char) when char in @alphabet do
    @alpha_to_index[char]
    |> then(&Integer.mod(a * &1 + b, @alpha_length))
    |> then(&@index_to_alpha[&1])
  end

  defp encode_letter(_, _, char), do: char

  defp decode_letter(inv_a, b, char) when char in @alphabet do
    @alpha_to_index[char]
    |> then(&Integer.mod(inv_a * (&1 - b), @alpha_length))
    |> then(&@index_to_alpha[&1])
  end

  defp decode_letter(_, _, char), do: char

  defp ok(n), do: {:ok, n}
end
