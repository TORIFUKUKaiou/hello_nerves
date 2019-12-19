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

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end

  defp cities, do: Lwwsx.cities()
end
