defmodule Qiita.Events.Qiita668cbcb3b0f037d55e27 do
  alias Qiita.Events.Qiita668cbcb3b0f037d55e27.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:機械学習"
    start_time = DateTime.new(~D[2022-10-04], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-11-01], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】機械学習を発展させるための知識を発信しよう！ いいねランキング！"
    id = "8b6abb91d952ffc92e90"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
