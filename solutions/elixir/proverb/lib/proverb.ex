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

  def pairs([_]), do: []
  def pairs([first, second | rest]) do
    ["For want of a #{first} the #{second} was lost." | pairs([second | rest])]
  end

  defp final_line(string), do: "And all for the want of a #{string}.\n"
end
