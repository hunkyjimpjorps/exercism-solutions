defmodule TopSecret do
  @moduledoc false
  def to_ast(string) do
    with {:ok, q} <- Code.string_to_quoted(string), do: q
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {f, _line, [{:when, _, [{name, _, args}, _]}, _]} when f in [:def, :defp] ->
        {ast, [Atom.to_string(name) |> String.slice(0, length(args)) | acc]}

      {f, _line, [{_, _, nil}, _body]} when f in [:def, :defp] ->
        {ast, ["" | acc]}

      {f, _line, [{name, _, args}, _body]} when f in [:def, :defp] ->
        {ast, [Atom.to_string(name) |> String.slice(0, length(args)) | acc]}

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message(string) do
    with {_, code} <- Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2) do
      code
      |> Enum.reverse()
      |> Enum.join()
    end
  end
end
