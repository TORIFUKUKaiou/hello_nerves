defmodule Qiita.Events.QiitaEngineerFesta2022RemoteTestKit do
  alias Qiita.Events.QiitaEngineerFesta2022RemoteTestKit.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_NTTレゾナント tag:RemoteTestKit"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "AdventCalendar2022",
      "QiitaEngineerFesta_NTTレゾナント",
      "RemoteTestKit",
      "QiitaEngineerFesta2022"
    ]

    title = "【毎日自動更新】Remote TestKitを使ってレビューを書こう！ LGTMランキング！"
    id = "b4abf0735dad68e0cc11"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
