defmodule Weather.Forecast do
  def text(city) do
    {:ok, text} = Lwwsx.current_text(city)
    text
  end

  def run({city, name}) do
    text =
      text(city)
      |> String.split()
      |> Enum.reduce_while("#{name}\n", fn s, acc ->
        if String.length(acc <> "#{s}\n") < 140 - String.length(i_use_nerves()),
          do: {:cont, acc <> "#{s}\n"},
          else: {:halt, acc}
      end)

    if String.length(text) <= String.length("#{name}\n"), do: raise(Weather.Error)

    text <> i_use_nerves()
  end

  def run do
    cities() |> Enum.random() |> run
  end

  def text_and_temperature(city) do
    json = Lwwsx.current(city) |> elem(1)

    text =
      json
      |> Map.get("description")
      |> Map.get("text")
      |> String.split()
      |> Enum.take(2)
      |> Enum.join()

    temperature =
      json |> Map.get("forecasts") |> Enum.at(0) |> Map.get("temperature") |> temperature()

    text <> temperature
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end

  defp cities, do: Lwwsx.cities()

  defp temperature(%{"max" => %{"celsius" => max}, "min" => nil}) do
    "最高気温は#{max}度です。"
  end

  defp temperature(%{"max" => nil, "min" => %{"celsius" => min}}) do
    "最低気温は#{min}度です。"
  end

  defp temperature(%{"max" => %{"celsius" => max}, "min" => %{"celsius" => min}}) do
    "最高気温は#{max}度、最低気温は#{min}度です。"
  end

  defp temperature(_) do
    ""
  end
end
