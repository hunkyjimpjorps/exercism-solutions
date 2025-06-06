defmodule RobotSimulator do
  defstruct direction: :north, x: 0, y: 0

  @type robot :: %__MODULE__{direction: direction, x: integer, y: integer}
  @type direction :: :north | :east | :south | :west
  @type position_tuple :: {integer, integer}
  @type maybe_robot :: robot | {:error, binary}

  @valid_directions ~w/north east south west/a

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position_tuple) :: maybe_robot
  def create(), do: %__MODULE__{}

  def create(direction, {x, y})
      when direction in @valid_directions and is_number(x) and is_number(y) do
    %__MODULE__{direction: direction, x: x, y: y}
  end

  def create(direction, _) when direction not in @valid_directions,
    do: {:error, "invalid direction"}

  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: maybe_robot
  def simulate(robot, ""), do: robot

  def simulate(robot, <<dir, rest::binary>>) do
    case dir do
      ?R -> simulate(rotate_right(robot), rest)
      ?L -> simulate(rotate_left(robot), rest)
      ?A -> simulate(advance(robot), rest)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp rotate_right(robot) do
    new_dir =
      case robot.direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %__MODULE__{robot | direction: new_dir}
  end

  defp rotate_left(robot) do
    new_dir =
      case robot.direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %__MODULE__{robot | direction: new_dir}
  end

  defp advance(robot) do
    case robot.direction do
      :north -> %__MODULE__{robot | y: robot.y + 1}
      :east -> %__MODULE__{robot | x: robot.x + 1}
      :south -> %__MODULE__{robot | y: robot.y - 1}
      :west -> %__MODULE__{robot | x: robot.x - 1}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: direction
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: position_tuple()
  def position(robot) do
    {robot.x, robot.y}
  end
end
