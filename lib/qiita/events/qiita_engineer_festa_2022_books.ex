defmodule Qiita.Events.QiitaEngineerFesta2022Books do
  alias Qiita.Events.QiitaEngineerFesta2022Books.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_技術書"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "40代駆け出しエンジニア",
      "AdventCalendar2022",
      "QiitaEngineerFesta_技術書",
      "QiitaEngineerFesta2022"
    ]

    title = "【毎日自動更新】買ってよかった技術書を紹介しよう！ LGTMランキング！"
    id = "24f5d98638b4aae9f56e"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
