defmodule Qiita.Events.QiitaEngineerFesta2022Incident do
  alias Qiita.Events.QiitaEngineerFesta2022Incident.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_インシデント"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_インシデント"]
    title = "【毎日自動更新】私が体験した1番ゾッとするインシデントの話 LGTMランキング！"
    id = "24d45a65cadd0a65809e"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
