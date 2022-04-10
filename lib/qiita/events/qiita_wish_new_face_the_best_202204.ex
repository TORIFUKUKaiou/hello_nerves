defmodule Qiita.Events.QiitaWishNewFaceTheBest202204 do
  alias Qiita.Events.QiitaWishNewFaceTheBest202204.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:新人プログラマ応援"
    start_time = DateTime.new(~D[2022-03-27], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-04-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "新人プログラマ応援", "Qiitadelika", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】新人プログラマ応援 - みんなで新人を育てよう！（2022年04月） LGTMランキング！"
    id = "18dad64ba99aa5a40f95"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
