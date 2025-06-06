defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0,
  ]

  def new() do
    new("none")
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      charge -> "Battery at #{charge}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    case remote_car.battery_percentage do
      0 -> remote_car
      _ -> Map.update!(remote_car, :battery_percentage, &(&1 - 1))
            |> Map.update!(:distance_driven_in_meters, &(&1 + 20))
    end
  end
end
