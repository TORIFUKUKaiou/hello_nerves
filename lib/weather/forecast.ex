defmodule Weather.Forecast do
  @api_key Application.compile_env(:hello_nerves, :open_weather_api_key)

  def run(%{"coord" => %{"lat" => lat, "lon" => lon}}) do
    name = "飯塚"

    %{"daily" => dailies} =
      onecall(lat, lon)
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    description =
      dailies |> Enum.at(0) |> Map.get("weather") |> Enum.at(0) |> Map.get("description")

    temp_max = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("max")
    temp_min = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("min")

    "#{name}の天気は、#{description}です。\n最高気温は#{temp_max}度です。最低気温は#{temp_min}度です。\n\n#{i_use_nerves()}"
  end

  defp onecall(lat, lon) do
    "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&lang=ja&units=metric&exclude=current,minutely,hourly&appid=#{@api_key}"
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end
end
