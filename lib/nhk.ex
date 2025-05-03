defmodule Nhk do
  @area Application.compile_env(:hello_nerves, :nhk_area)
  @favorite_acts Application.compile_env(:hello_nerves, :nhk_favorite_acts)
  @favorite_titles Application.compile_env(:hello_nerves, :nhk_favorite_titles)

  def run do
    first = DateTime.utc_now() |> DateTime.add(9 * 60 * 60, :second)
    last = first |> DateTime.add(2 * 24 * 60 * 60, :second)

    dates =
      Date.range(DateTime.to_date(first), DateTime.to_date(last)) |> Enum.map(&Date.to_string/1)

    for service <- services(), date <- dates do
      {service, date}
    end
    |> Flow.from_enumerable()
    |> Flow.partition()
    |> Flow.flat_map(fn {service, date} ->
      Nhk.Api.get(@area, service, date)
    end)
    |> Flow.filter(fn %{"act" => act, "title" => title} ->
      favorite_act?(act) || favorite_title?(title)
    end)
    |> Flow.map(fn %{
                     "act" => act,
                     "service" => %{"name" => service_name},
                     "start_time" => start_time,
                     "title" => title,
                     "area" => %{"name" => area_name}
                   } ->
      {"#{start_time}(#{service_name} / #{area_name})\n#{title}\n#{act} ", start_time}
    end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {_, start_time} -> start_time end)
    |> Enum.map(fn {txt, _} -> txt end)
    |> Enum.map(&(&1 <> i_use_nerves()))
    |> post()
  end

  defp services do
    ["g1", "e1", "e4", "s1", "s3", "r1", "r2", "r3"]
  end

  defp favorite_act?(act) do
    String.split(@favorite_acts, ",")
    |> Enum.any?(&String.contains?(act, &1))
  end

  defp favorite_title?(title) do
    String.split(@favorite_titles, ",")
    |> Enum.any?(&String.contains?(title, &1))
  end

  defp post([]) do
  end

  defp post(list) do
    list
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "\n\nI use Nerves. I like it!"
    else
      ""
    end
  end
end
