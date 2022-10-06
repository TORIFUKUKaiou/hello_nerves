defmodule Qiita.Events.Qiita8e3542610897d988e66d do
  alias Qiita.Events.Qiita8e3542610897d988e66d.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:PHP"
    start_time = DateTime.new(~D[2022-10-04], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-11-01], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】PHP強化月間～開発する上で知っておくべき知見を共有しよう～ LGTMランキング！"
    id = "a50b97bd532cf971e867"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
