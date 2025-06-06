defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, char)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(bread, char), do: {nil, Map.update!(char, :health, &(&1 + 5))}
  end

  defimpl Edible, for: ManaPotion do
    def eat(potion, char), do: {%EmptyBottle{}, Map.update!(char, :mana, &(&1 + potion.strength))}
  end

  defimpl Edible, for: Poison do
    def eat(_, char), do: {%EmptyBottle{}, %{char | health: 0}}
  end
end
