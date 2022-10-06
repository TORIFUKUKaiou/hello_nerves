defmodule Qiita.Events.Qiita5fdc281997d5754d8ac9 do
  alias Qiita.Events.Qiita5fdc281997d5754d8ac9.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:フロントエンド"
    start_time = DateTime.new(~D[2022-10-04], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-11-01], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】フロントエンドの開発効率を向上するヒントを教え合おう！ いいねランキング！"
    id = "93504a92bb68ec918a6a"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
