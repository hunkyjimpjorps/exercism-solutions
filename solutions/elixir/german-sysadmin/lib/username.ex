defmodule Username do
  def sanitize(username) do
    username
    |> Enum.map(fn x ->
      case x do
        ?ä -> ~c/ae/
        ?ö -> ~c/oe/
        ?ü -> ~c/ue/
        ?ß -> ~c/ss/
         _ -> x
      end
    end)
    |> List.flatten()
    |> Enum.filter(&(&1 in Enum.concat([?_], ?a..?z)))
  end
end
