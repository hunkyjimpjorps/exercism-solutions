defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  @doc """
  Find the quickest way to fill a bucket with some amount of water from two buckets of specific sizes.
  """
  @spec measure(
          max1 :: integer,
          max2 :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}

  def measure(max1, max2, goal, start) do
    cond do
      goal > max1 and goal > max2 -> {:error, :impossible}
      rem(goal, gcd(max1, max2)) != 0 -> {:error, :impossible}
      true -> begin_measurements({max1, max2}, goal, start)
    end
  end

  defp begin_measurements({max1, max2} = buckets, goal, start) do
    no_go =
      case start do
        :one -> [{0, max2}]
        :two -> [{max1, 0}]
      end
      |> MapSet.new()

    next_pour([{0, {0, 0}}], no_go, buckets, goal)
  end

  defp next_pour([], _, _, _), do: {:error, :impossible}

  defp next_pour([{moves, {current1, current2}} | _], _, _, goal)
       when current1 == goal or current2 == goal do
    {:ok, %TwoBucket{bucket_one: current1, bucket_two: current2, moves: moves}}
  end

  defp next_pour([{moves, state} | rest], no_go, buckets, goal) do
    next =
      maybe_next(state, buckets)
      |> Enum.reject(&(&1 in no_go))
      |> Enum.map(&{moves + 1, &1})
      |> then(&(rest ++ &1))

    no_go = MapSet.put(no_go, state)

    next_pour(next, no_go, buckets, goal)
  end

  defp maybe_next({current1, current2}, {max1, max2}) do
    [
      # empty bucket 1
      {0, current2},
      # empty bucket 2
      {current1, 0},
      # fill up bucket 1
      {max1, current2},
      # fill up bucket 2
      {current1, max2},
      cond do
        # pour all from bucket 1 to bucket 2, or
        current1 < max2 - current2 -> {0, current1 + current2}
        # fill up bucket 2 using part of bucket 1
        true -> {current1 - (max2 - current2), max2}
      end,
      cond do
        # pour all from bucket 2 to bucket 1, or
        current2 < max1 - current1 -> {current1 + current2, 0}
        # fill up bucket 1 using part of bucket 2
        true -> {max1, current2 - (max1 - current1)}
      end
    ]
    |> Enum.uniq()
  end

  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))
end
