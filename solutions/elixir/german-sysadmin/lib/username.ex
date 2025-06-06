defmodule Username do
  def sanitize(username) do
    username
    |> Enum.filter(fn c -> c >= ?a && c <= ?z end)
  end
end
