defmodule Weather.Forecast do
  @api_key Application.get_env(:hello_nerves, :open_weather_api_key)
  @city_list_json "/usr/local/share/city.list.json"

  def run(city) do
    %{
      "name" => name,
      "weather" => weathers,
      "main" => %{"temp_max" => temp_max, "temp_min" => temp_min}
    } =
      city
      |> url()
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    description = weathers |> Enum.at(0) |> Map.get("description")

    "#{name}の天気は、#{description}です。\n最高気温は#{temp_max}℃です。最低気温は#{temp_min}℃です。\n\n#{i_use_nerves()}"
  end

  def run do
    cities()
    |> Enum.random()
    |> run()
  end

  defp url(city) do
    "http://api.openweathermap.org/data/2.5/weather?id=#{city}&lang=ja&units=metric&appid=#{
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
    |> Enum.map(fn %{"id" => id} -> id end)
  end
end
