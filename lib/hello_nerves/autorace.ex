defmodule HelloNerves.Autorace do
  def today do
    DateTime.utc_now()
    |> DateTime.add(9 * 60 * 60)
    |> DateTime.to_date()
    |> search()
  end

  def search(date) do
    places()
    |> Enum.reduce([], fn {name, url}, acc ->
      Process.sleep(15000)
      result_list = _get(url, date)

      if Enum.empty?(result_list) do
        acc
      else
        acc ++ [{name, List.first(result_list)}]
      end
    end)
  end

  def places do
    [
      {"川口", "https://autorace.jp/netstadium/Player/kawaguchi"},
      {"伊勢崎", "https://autorace.jp/netstadium/Player/isesaki"},
      {"浜松", "https://autorace.jp/netstadium/Player/hamamatsu"},
      {"飯塚", "https://autorace.jp/netstadium/Player/iizuka"},
      {"鉄壁山陽", "https://autorace.jp/netstadium/Player/sanyou"}
    ]
  end

  defp _get(url, date) do
    HTTPoison.get!(url, [], ssl: [{:ciphers, [~c"AES256-SHA256"]}])
    |> Map.get(:body)
    |> Floki.parse_fragment!()
    |> Floki.find("h3.h3_ttl")
    |> Enum.map(fn t -> elem(t, 2) end)
    |> Enum.map(&List.first/1)
    |> Enum.map(fn s ->
      ~r/(?<title>.+)　(?<begin_month>\d{2})\/(?<begin_day>\d{2})～(?<end_month>\d{2})\/(?<end_day>\d{2})/
      |> Regex.named_captures(s)
    end)
    |> Enum.map(&_convert(&1, date))
    |> Enum.filter(fn m ->
      Enum.member?(m[:range], date)
    end)
  end

  defp _convert(m, date) do
    now_year = date.year

    {:ok, first} =
      Date.new(now_year, String.to_integer(m["begin_month"]), String.to_integer(m["begin_day"]))

    {:ok, last} =
      if "#{m["begin_month"]}#{m["begin_day"]}" < "#{m["end_month"]}#{m["end_day"]}" do
        Date.new(now_year, String.to_integer(m["end_month"]), String.to_integer(m["end_day"]))
      else
        Date.new(
          now_year + 1,
          String.to_integer(m["end_month"]),
          String.to_integer(m["end_day"])
        )
      end

    %{
      title: m["title"],
      range: Date.range(first, last)
    }
  end
end
