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

  def tweet_autorace do
    HelloNerves.Autorace.today()
    |> Enum.map(fn {place, %{title: title}} ->
      "#{greet()}\n本日は#{place}オートで、#{title}が開催されます。\n\n#autorace #オートレース ##{place}オート"
    end)
    |> Enum.each(&update/1)
  end

  def sound_forecast(city) do
    try do
      _sound_forecast(city)
    rescue
      _e ->
        Process.sleep(15000)
        spawn(HelloNerves, :sound_forecast, [city])
    end
  end

  defp _sound_forecast(city) do
    content =
      Weather.Forecast.text(city)
      |> String.split()
      |> Enum.take(2)
      |> Enum.join()
      |> DocomoTextToSpeech.run!()

    {path, play_cmd} =
      if Application.get_env(:hello_nerves, :target) != :host,
        do: {"/tmp/output.wav", 'aplay -q /tmp/output.wav'},
        else: {"output.wav", 'afplay output.wav'}

    File.write(path, content)
    1..3 |> Enum.each(fn _ -> :os.cmd(play_cmd) end)
  end

  defp greet do
    ["Seize the day", "Good morning!", "Morning!", "I bid you good morning.", "Morning buddy!"]
    |> Enum.random()
  end
end
