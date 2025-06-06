defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> (&(Regex.replace(~r/'/, &1, ""))).()
    |> (&(Regex.replace(~r/[_\-\s]+/, &1, " "))).()
    |> String.split()
    |> Enum.map(fn w -> String.at(w, 0) |> String.upcase() end)
    |> Enum.join()
  end
end