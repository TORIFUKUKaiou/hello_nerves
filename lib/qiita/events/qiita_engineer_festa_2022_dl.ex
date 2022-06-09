defmodule Qiita.Events.QiitaEngineerFesta2022DL do
  alias Qiita.Events.QiitaEngineerFesta2022DL.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_深層学習"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "40代駆け出しエンジニア",
      "AdventCalendar2022",
      "QiitaEngineerFesta_深層学習",
      "QiitaEngineerFesta2022"
    ]

    title = "【毎日自動更新】深層学習の論文について解説してみた LGTMランキング！"
    id = "fd8ffc3b260d5dbaf145"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
