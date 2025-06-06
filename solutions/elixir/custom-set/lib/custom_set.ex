defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: []

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %CustomSet{map: enumerable |> Enum.uniq() |> Enum.sort()}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.map == []
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    element in custom_set.map
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.map, &Enum.member?(custom_set_2.map, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.map, fn x -> not Enum.member?(custom_set_2.map, x) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1.map == custom_set_2.map
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    new([element | custom_set.map])
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    for(
      x <- custom_set_1.map ++ custom_set_2.map,
      x in custom_set_1.map && x in custom_set_2.map,
      do: x
    )
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    for(
      x <- custom_set_1.map,
      x not in custom_set_2.map,
      do: x
    )
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    new(custom_set_1.map ++ custom_set_2.map)
  end
end