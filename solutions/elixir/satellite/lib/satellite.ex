defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree(preorder, inorder) when length(preorder) != length(inorder) do
    {:error, "traversals must have the same length"}
  end

  def build_tree(preorder, inorder) do
    cond do
      Enum.uniq(preorder) != preorder or Enum.uniq(inorder) != inorder ->
        {:error, "traversals must contain unique items"}

      MapSet.new(preorder) != MapSet.new(inorder) ->
        {:error, "traversals must have the same elements"}

      true ->
        {:ok, do_build_tree(preorder, inorder)}
    end
  end

  defp do_build_tree([], []), do: {}
  defp do_build_tree([root], [root]), do: {{}, root, {}}

  defp do_build_tree([root | rest], inorder) do
    {in_l, [_ | in_r]} = Enum.split_while(inorder, &(&1 != root))
    pre_l = Enum.filter(rest, &(&1 in in_l))
    pre_r = Enum.filter(rest, &(&1 in in_r))

    {do_build_tree(pre_l, in_l), root, do_build_tree(pre_r, in_r)}
  end
end
