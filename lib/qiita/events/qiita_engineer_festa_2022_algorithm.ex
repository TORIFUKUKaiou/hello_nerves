defmodule Qiita.Events.QiitaEngineerFesta2022Algorithm do
  alias Qiita.Events.QiitaEngineerFesta2022Algorithm.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_アルゴリズム"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "40代駆け出しエンジニア",
      "AdventCalendar2022",
      "QiitaEngineerFesta_アルゴリズム",
      "QiitaEngineerFesta2022"
    ]

    title = "【毎日自動更新】アルゴリズム強化月間 - 楽しいアルゴリズムの世界を紹介しよう - LGTMランキング！"
    id = "8593958b584f07fab756"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
