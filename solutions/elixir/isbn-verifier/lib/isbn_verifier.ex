defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  def isbn_checksum(isbn) do
    Enum.zip_reduce(
      Enum.map(String.graphemes(isbn), fn c -> if(c == "X", do: 10, else: String.to_integer(c)) end),
      Enum.to_list(10..1//-1),
      0,
      fn d, n, acc -> acc + d * n end
    )
  end

  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn_clean = Regex.replace(~r/-/, isbn, "")

    cond do
      not (String.length(isbn_clean) == 10) -> false
      not Regex.match?(~r/^[0-9]{9}[0-9X]$/, isbn_clean) -> false
      Integer.mod(isbn_checksum(isbn_clean), 11) != 0 -> false
      true -> true
    end
  end
end