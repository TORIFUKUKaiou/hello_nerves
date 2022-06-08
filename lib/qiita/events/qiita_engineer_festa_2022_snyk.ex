defmodule Qiita.Events.QiitaEngineerFesta2022Snyk do
  alias Qiita.Events.QiitaEngineerFesta2022Snyk.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Snyk"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_Snyk"]
    title = "【毎日自動更新】Snykを使って開発者セキュリティに関する記事を投稿しよう！ LGTMランキング！"
    id = "444c8d465b48015f5b01"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
