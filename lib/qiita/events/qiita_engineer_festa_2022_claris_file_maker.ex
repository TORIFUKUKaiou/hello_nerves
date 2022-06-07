defmodule Qiita.Events.QiitaEngineerFesta2022ClarisFileMaker do
  alias Qiita.Events.QiitaEngineerFesta2022ClarisFileMaker.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Claris tag:ClarisFileMaker"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_Claris", "ClarisFileMaker"]
    title = "【毎日自動更新】Claris FileMaker で作った App を JavaScript で拡張したらどうなる？！ LGTMランキング！"
    id = "f8497d8ad7deb69069c4"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
