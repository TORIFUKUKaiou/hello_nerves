defmodule Qiita.Events.Qiitadelika202203 do
  alias Qiita.Events.Qiitadelika202203.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:Qiitadelika OR tag:delika"
    start_time = DateTime.new(~D[2022-03-13], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-04-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "delika", "Qiitadelika", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】データに関する記事を書こう！ LGTMランキング！"
    id = "b10fa94764aaaa2c6db1"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
