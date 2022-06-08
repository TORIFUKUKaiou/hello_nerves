defmodule Qiita.Events.QiitaEngineerFesta2022Sekkei do
  alias Qiita.Events.QiitaEngineerFesta2022Sekkei.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_設計"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_設計"]
    title = "【毎日自動更新】悪いコードを改善した時の体験や知見を共有しよう LGTMランキング！"
    id = "eb78dc01165858d94004"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
