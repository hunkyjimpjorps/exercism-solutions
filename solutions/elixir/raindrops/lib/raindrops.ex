defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """

  defp make_a_sound?(n, {factor, sound}) do
    if Integer.mod(n, factor) == 0, do: sound, else: ""
  end

  @factors %{3 => "Pling", 5 => "Plang", 7 => "Plong"}
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.map_join(@factors, &(make_a_sound?(number, &1)))
    |> (&(if &1 == "", do: Integer.to_string(number), else: &1)).()
  end
end
