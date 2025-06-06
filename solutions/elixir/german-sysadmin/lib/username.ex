defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize(username) do
    username
    |> Enum.reduce('', fn c, s ->
      s ++
        case c do
          ?ä -> [?a, ?e]
          ?ö -> [?o, ?e]
          ?ü -> [?u, ?e]
          ?ß -> [?s, ?s]
          ?_ -> [?_]
          c when c in ?a..?z -> [c]
          _ -> []
        end
    end)
  end
end
