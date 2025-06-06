defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(?A), do: "A\n"

  def build_shape(letter) do
    letters = Enum.concat(?A..letter, (letter - 1)..?A)

    for l <- letters do
      case l do
        ?A -> a_row(letter)
        l -> row(l, letter)
      end
    end
    |> Enum.join("\n")
    |> (&(&1 <> "\n")).()
  end

  defp a_row(letter),
    do: String.duplicate(" ", letter - ?A) <> "A" <> String.duplicate(" ", letter - ?A)

  defp row(l, letter) do
    str_l = List.to_string([l])

    String.duplicate(" ", letter - l) <>
      str_l <>
      String.duplicate(" ", 2 * (l - ?A) - 1) <>
      str_l <>
      String.duplicate(" ", letter - l)
  end
end
