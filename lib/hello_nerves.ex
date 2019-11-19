defmodule HelloNerves do
  @moduledoc """
  Documentation for HelloNerves.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HelloNerves.hello
      :world

  """
  def hello do
    :world
  end

  def update(status) do
    ExTwitter.update(status)
  end

  def update do
    try do
      Weather.Forecast.run() |> update()
    rescue
      _e in Weather.Error ->
        Process.sleep(15000)
        update()
    end
  end
end
