defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }
  alias DndCharacter, as: Dnd
  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    floor((score - 10) / 2)
  end

  @spec ability :: pos_integer()
  def ability do
    List.duplicate(0, 4)
    |> Enum.map(fn _ -> :rand.uniform(6) end)
    |> Enum.sort()
    |> tl()
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    %Dnd{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }
    |> (&%Dnd{&1 | hitpoints: 10 + modifier(&1.constitution)}).()
  end
end
