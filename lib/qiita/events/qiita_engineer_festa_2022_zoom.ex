defmodule Qiita.Events.QiitaEngineerFesta2022Zoom do
  alias Qiita.Events.QiitaEngineerFesta2022Zoom.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Zoom tag:Zoom"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_Zoom", "Zoom"]
    title = "【毎日自動更新】Zoom API/SDKを使ってみよう！ LGTMランキング！"
    id = "3b232899320ee2f1ceec"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
