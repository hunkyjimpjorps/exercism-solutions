defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @alphabet ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    cipher_map = make_cipher_map(shift)

    for <<c <- text>>, into: "" do
      <<Map.get(cipher_map, c, c)>>
    end
  end

  defp make_cipher_map(shift) do
    shifted = @alphabet |> Stream.cycle() |> Stream.drop(shift)

    Enum.zip([@alphabet, shifted])
    |> Enum.flat_map(fn {from, to} -> [{from, to}, {from + 32, to + 32}] end)
    |> Enum.into(%{})
  end
end
