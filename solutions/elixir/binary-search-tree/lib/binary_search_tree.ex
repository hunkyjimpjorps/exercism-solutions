defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree = %{data: root, left: left_leaf, right: right_leaf}, data) do
    cond do
      data <= root ->
        if is_nil(left_leaf),
          do: %{tree | left: new(data)},
          else: %{tree | left: insert(left_leaf, data)}

      data > root ->
        if is_nil(right_leaf),
          do: %{tree | right: new(data)},
          else: %{tree | right: insert(right_leaf, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: root, left: left_leaf, right: right_leaf}) do
    in_order(left_leaf) ++ [root] ++ in_order(right_leaf)
  end
end
