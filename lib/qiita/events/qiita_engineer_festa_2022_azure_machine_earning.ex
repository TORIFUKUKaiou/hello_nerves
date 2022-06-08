defmodule Qiita.Events.QiitaEngineerFesta2022AzureMachineLearning do
  alias Qiita.Events.QiitaEngineerFesta2022AzureMachineLearning.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Azure tag:AzureMachineLearning"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    tags = [
      "Elixir",
      "40代駆け出しエンジニア",
      "AdventCalendar2022",
      "QiitaEngineerFesta_Azure",
      "AzureMachineLearning"
    ]

    title = "【毎日自動更新】Azure Machine Learning を使って機械学習に関するナレッジをシェアしよう LGTMランキング！"
    id = "7194a4352af5ba780e03"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
