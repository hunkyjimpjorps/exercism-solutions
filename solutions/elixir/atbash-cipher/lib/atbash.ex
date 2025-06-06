defmodule Atbash do
  @atbash_map [[?a..?z, ?z..?a], [?0..?9, ?0..?9]]
              |> Enum.map(&Enum.zip/1)
              |> Enum.concat()
              |> Enum.into(%{}, fn {to, from} -> {to, from} end)

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    Regex.replace(~r/[^a-z0-9]/, String.downcase(plaintext), "")
    |> String.to_charlist()
    |> Enum.map(&Map.fetch!(@atbash_map, &1))
    |> Enum.chunk_every(5)
    |> Enum.map_join(" ", &List.to_string/1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    Regex.replace(~r/\s/, cipher, "")
    |> String.to_charlist()
    |> Enum.map(&Map.fetch!(@atbash_map, &1))
    |> List.to_string()
  end
end
