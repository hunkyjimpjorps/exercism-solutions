defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([first | _] = strings) do
    pairs(strings) ++ [final_line(first)]
    |> Enum.join("\n")
  end

  defp pairs([_]), do: []
  defp pairs([first, second | rest]) do
    ["For want of a #{first} the #{second} was lost." | pairs([second | rest])]
  end

  defp final_line(string), do: "And all for the want of a #{string}.\n"
end
