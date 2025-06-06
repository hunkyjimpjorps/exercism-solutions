defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_ | xs]), do: 1 + count(xs)

  @spec reverse(list) :: list
  def reverse(xs), do: reverse(xs, [])
  @spec reverse(list, any) :: any
  def reverse([], acc), do: acc
  def reverse([x | xs], acc), do: reverse(xs, [x | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([x | xs], f), do: [f.(x) | map(xs, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([x | xs], f), do: if(f.(x), do: [x | filter(xs, f)], else: filter(xs, f))

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _), do: acc
  def foldl([x | xs], acc, f), do: foldl(xs, f.(x, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: foldl(reverse(l), acc, f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([a | as], b), do: [a | append(as, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([x | xs]) when is_list(x), do: append(x, concat(xs))
  def concat([x | xs]), do: [x | concat(xs)]
end
