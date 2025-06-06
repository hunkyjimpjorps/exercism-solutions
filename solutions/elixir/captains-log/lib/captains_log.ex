defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number() do
    "NCC-#{:rand.uniform(8999) + 1000}"
  end

  def random_stardate() do
    :rand.uniform() * 1000 + 41000
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string
  end
end
