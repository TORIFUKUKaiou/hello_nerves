defmodule Qiita.Events.Qiitaae80b010f51f7018891a do
  alias Qiita.Events.Qiitaae80b010f51f7018891a.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:Go"
    start_time = DateTime.new(~D[2022-08-14], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-09-16], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】Go強化月間～開発する上で知っておくべき知見を共有しよう～ LGTMランキング！"
    id = "1e2ab051ef422f040fd2"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
