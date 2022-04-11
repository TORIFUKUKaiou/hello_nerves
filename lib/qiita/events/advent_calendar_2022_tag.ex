defmodule Qiita.Events.AdventCalendar2022Tag do
  alias Qiita.Events.AdventCalendar2022Tag.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:AdventCalendar2022"
    start_time = DateTime.new(~D[2000-01-01], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2099-12-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】AdventCalendar2022 タグ LGTMランキング！"
    id = "6cbea79ccf0eea8777d2"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
