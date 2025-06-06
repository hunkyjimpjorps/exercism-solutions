defmodule Zipper do
  alias BinTree, as: B

  @type trail :: :top | {:left, B.t(), trail} | {:right, B.t(), trail}
  @type t :: %Zipper{tree: B.t(), trail: trail}

  defstruct [:tree, :trail]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{tree: bin_tree, trail: :top}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{tree: tree, trail: :top}), do: tree
  def to_tree(zip), do: to_tree(up(zip))

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{tree: %B{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{tree: %B{left: nil}}), do: nil

  def left(%Zipper{tree: %B{left: left} = tree, trail: trail}) do
    %Zipper{tree: left, trail: {:left, tree, trail}}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{tree: %B{right: nil}}), do: nil

  def right(%Zipper{tree: %B{right: right} = tree, trail: trail}) do
    %Zipper{tree: right, trail: {:right, tree, trail}}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{trail: :top}), do: nil
  def up(%Zipper{trail: {_, tree, trail}}), do: %Zipper{tree: tree, trail: trail}

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    propagate_changes(zipper, {value, :value})
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    propagate_changes(zipper, {left, :left})
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    propagate_changes(zipper, {right, :right})
  end

  defp propagate_changes(%Zipper{tree: tree, trail: trail} = z, {value, kind}) do
    case trail do
      :top ->
        %Zipper{z | tree: Map.put(tree, kind, value)}

      {direction, _, _} ->
        tree = Map.put(tree, kind, value)
        %Zipper{tree: up, trail: up_trail} = propagate_changes(up(z), {tree, direction})
        %Zipper{tree: tree, trail: {direction, up, up_trail}}
    end
  end
end
