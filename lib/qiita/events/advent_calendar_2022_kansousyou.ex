defmodule Qiita.Events.AdventCalendar2022Kansousyou do
  alias Qiita.Events.AdventCalendar2022Kansousyou.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "猪木", "闘魂"]
    title = "闘魂Elixir ── 03. 完走賞を目指してみましょう！【自動更新記事】"
    id = "17d55cf896c24b13350e"

    items()
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end

  defp items do
    with %{status: 200, body: html} <- Req.get!("https://qiita.com/advent-calendar/2022/elixir"),
         {:ok, parsed_doc} <- Floki.parse_document(html),
         [{_tag, _attrs, json} | _] <-
           Floki.find(parsed_doc, "[data-js-react-on-rails-store=AppStoreWithReactOnRails]"),
         {:ok, decoded} <- Jason.decode(json),
         [table_advent_calendars | _] <-
           get_in(decoded, ["adventCalendars", "tableAdventCalendars"]) do
      table_advent_calendars
      |> Map.fetch!("items")
      |> Enum.frequencies_by(&get_in(&1, ["user", "urlName"]))
      |> Enum.sort_by(fn {_user, cnt} -> cnt end, :desc)
    else
      _ -> :error
    end
  end
end
