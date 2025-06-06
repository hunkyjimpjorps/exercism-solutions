defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []
  end 

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(encoded) do
    with chars <- String.to_charlist(encoded),
         {:ok, tokens, _} <- :sgf_lexer.string(chars),
         {:ok, result} <- :sgf_parser.parse(tokens) do
      {:ok, convert_to_struct(result)}
    else
      {:error, {1, :sgf_parser, :no_tree}} -> {:error, "tree missing"}
      {:error, {1, :sgf_parser, :no_nodes}} -> {:error, "tree with no nodes"}
      {:error, {1, :sgf_parser, :no_delim}} -> {:error, "properties without delimiter"}
      {:error, {1, :sgf_parser, :bad_key}} -> {:error, "property must be in uppercase"}
      other -> other
    end
  end

  defp convert_to_struct(map) when map == %{properties: %{}}, do: %Sgf{}
  defp convert_to_struct(%{children: []} = map), do: struct(Sgf, map)

  defp convert_to_struct(map),
    do: struct(Sgf, %{map | children: Enum.map(map.children, &struct(Sgf, &1))})
end
