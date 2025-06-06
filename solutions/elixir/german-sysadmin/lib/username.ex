defmodule Username do
  def sanitize(username) do
    username
    |> Enum.filter(fn c -> c < 255 end)
    |> to_string()
    |> String.replace(["ä", "ö", "ü", "ß"], fn c ->
      case c do
        "ä" -> "ae"
        "ö" -> "oe"
        "ü" -> "ue"
        "ß" -> "ss"
      end
    end)
    |> (&Regex.replace(~r/[^a-z_]/, &1, "")).()
    |> to_charlist()
  end
end
