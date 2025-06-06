defmodule KitchenCalculator do
  @type volume_units :: :milliliter | :cup | :fluid_ounce | :teaspoon | :tablespoon
  @type volume_pair :: {volume_units(), number()}

  @spec get_volume(volume_pair()) :: number()
  def get_volume({_, vol}), do: vol

  @spec get_conversion_factor(volume_units()) :: integer()
  def get_conversion_factor(unit) do
    case unit do
      :milliliter -> 1
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
    end
  end

  @spec to_milliliter(volume_pair()) :: volume_pair()
  def to_milliliter({unit, vol}) do
    {:milliliter, vol * get_conversion_factor(unit)}
  end

  @spec from_milliliter({:milliliter, integer()}, volume_units()) :: volume_pair()
  def from_milliliter({:milliliter, vol}, new_unit) do
    {new_unit, vol / get_conversion_factor(new_unit)}
  end

  @spec convert(volume_pair(), volume_units()) :: volume_pair()
  def convert({unit, vol}, new_unit) do
    from_milliliter(to_milliliter({unit, vol}), new_unit)
  end
end
