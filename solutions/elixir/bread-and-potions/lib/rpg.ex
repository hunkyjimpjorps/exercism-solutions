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
    def eat(%LoafOfBread{}, %Character{health: h} = char) do
      {nil, %{char | health: h + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: m}, %Character{mana: mana} = char) do
      {%EmptyBottle{}, %{char | mana: mana + m}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{}, char) do
      {%EmptyBottle{}, %{char | health: 0}}
    end  
  end
end
