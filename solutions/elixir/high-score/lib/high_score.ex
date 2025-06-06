defmodule HighScore do
  @undefined_score 0
  def new(), do: %{}

  def add_player(scores, name, score \\ @undefined_score), do: Map.put(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name), do: Map.put(scores, name, 0)

  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn old_score -> old_score + score end)
  end

  def get_players(scores), do: Map.keys(scores)
end
