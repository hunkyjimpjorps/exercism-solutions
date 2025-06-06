defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input
    |> sanitize()
    |> categorize()
  end

  defp sanitize(input) do
    input
    |> String.trim()
    |> String.replace(~r/[^[:alnum:]!?\.]/u, "")
  end

  defp categorize(input) do
    cond do
      empty?(input) -> "Fine. Be that way!"
      shouting?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp empty?(input), do: input == ""

  defp shouting?(input) do
    input == String.upcase(input) and not String.match?(input, ~r/^[[:digit:]]*[!?.]*$/)
  end

  defp question?(input), do: String.last(input) == "?"
end
