defmodule AwesomeNerves do
  def tweet_autorace do
    AwesomeNerves.Autorace.today()
    |> Enum.map(fn {place, %{title: title}} ->
      "#{greet()}\n本日は#{place}オートで、#{title}が開催されます。\n\n#autorace #オートレース ##{place}オート"
    end)
  end

  def sound_forecast(city \\ %{"coord" => %{"lat" => 33.633331, "lon" => 130.683334}}, cnt \\ 1) do
    try do
      _sound_forecast(city, cnt)
    rescue
      _e ->
        Process.sleep(15000)
        spawn(AwesomeNerves, :sound_forecast, [city, cnt])
    end
  end

  def is_xmas?, do: Timex.now().month == 12

  defp _sound_forecast(city, cnt) do
    content = Weather.Forecast.run(city) |> Azure.TextToSpeech.run!()

    {path, play_cmd} =
      if Application.get_env(:awesome_nerves, :target) != :host,
        do: {"/tmp/output.wav", ~c"aplay -q /tmp/output.wav"},
        else: {"output.wav", ~c"afplay output.wav"}

    File.write(path, content)
    1..cnt |> Enum.each(fn _ -> :os.cmd(play_cmd) end)
  end

  defp greet do
    ["Seize the day", "Good morning!", "Morning!", "I bid you good morning.", "Morning buddy!"]
    |> Enum.random()
  end
end
