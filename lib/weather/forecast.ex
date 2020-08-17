defmodule Weather.Forecast do
  @api_key Application.get_env(:hello_nerves, :open_weather_api_key)
  @city_list_json "/usr/local/share/city.list.json"

  def run(%{"coord" => %{"lat" => lat, "lon" => lon}, "id" => city_id}) do
    %{
      "name" => name
    } =
      current(city_id)
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    %{"daily" => dailies} =
      onecall(lat, lon)
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    description =
      dailies |> Enum.at(0) |> Map.get("weather") |> Enum.at(0) |> Map.get("description")

    temp_max = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("max")
    temp_min = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("min")

    "#{name}の天気は、#{description}です。\n最高気温は#{temp_max}℃です。最低気温は#{temp_min}℃です。\n\n#{i_use_nerves()}"
  end

  def run do
    cities()
    |> Enum.random()
    |> run()
  end

  defp current(city_id) do
    "http://api.openweathermap.org/data/2.5/weather?id=#{city_id}&lang=ja&units=metric&appid=#{
      @api_key
    }"
  end

  defp onecall(lat, lon) do
    "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&lang=ja&units=metric&exclude=current,minutely,hourly&appid=#{
      @api_key
    }"
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end

  defp cities do
    path =
      if Application.get_env(:hello_nerves, :target) != :host,
        do: @city_list_json,
        else: "rootfs_overlay/#{@city_list_json}"

    File.read!(path)
    |> Jason.decode!()
    |> Enum.filter(fn %{"country" => country} -> country == "JP" end)
  end
end
