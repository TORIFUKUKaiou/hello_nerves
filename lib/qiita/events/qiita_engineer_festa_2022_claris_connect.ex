defmodule Qiita.Events.QiitaEngineerFesta2022ClarisConnect do
  alias Qiita.Events.QiitaEngineerFesta2022ClarisConnect.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Claris tag:ClarisConnect"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "AdventCalendar2022",
      "QiitaEngineerFesta_Claris",
      "ClarisConnect",
      "QiitaEngineerFesta2022"
    ]

    title = "【毎日自動更新】Claris Connect を使った SaaS 連携ユースケースを紹介しよう！ LGTMランキング！"
    id = "2a630ab5ad6b9bd427a9"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
