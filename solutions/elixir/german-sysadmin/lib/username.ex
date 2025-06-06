defmodule Username do
  def sanitize(username) do
    username
    |> Enum.map(fn x ->
      case x do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
         _ -> x
      end
    end)
    |> List.flatten()
    |> Enum.filter(&(&1 in Enum.concat([?_], ?a..?z)))
  end
end
