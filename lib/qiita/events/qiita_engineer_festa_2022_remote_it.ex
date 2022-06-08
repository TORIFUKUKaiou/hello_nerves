defmodule Qiita.Events.QiitaEngineerFesta2022RemoteIt do
  alias Qiita.Events.QiitaEngineerFesta2022RemoteIt.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_remote.it tag:remote.it"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "40代駆け出しエンジニア",
      "AdventCalendar2022",
      "QiitaEngineerFesta_remote.it",
      "remote.it"
    ]

    title = "【毎日自動更新】remote.it を使って○○に接続してみた！ LGTMランキング！"
    id = "f284b5be23bc6f1a4e5e"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
