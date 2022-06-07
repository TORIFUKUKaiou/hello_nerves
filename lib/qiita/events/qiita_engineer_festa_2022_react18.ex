defmodule Qiita.Events.QiitaEngineerFesta2022React18 do
  alias Qiita.Events.QiitaEngineerFesta2022React18.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_React18"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_React18"]
    title = "【毎日自動更新】React 18、あなたならどう使いこなす？ LGTMランキング！"
    id = "b02bc3073531dd42ba0f"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
