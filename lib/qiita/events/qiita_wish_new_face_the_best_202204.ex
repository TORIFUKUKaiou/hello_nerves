defmodule Qiita.Events.QiitaWishNewFaceTheBest202204 do
  alias Qiita.Events.QiitaWishNewFaceTheBest202204.MarkdownGenerator

  def run do
    start = DateTime.new(~D[2022-03-27], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2022-04-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    MarkdownGenerator.run(
      query: "tag:新人プログラマ応援",
      start_time: start,
      end_time: ending,
      tags: ["Elixir", "新人プログラマ応援", "Qiitadelika", "40代駆け出しエンジニア", "AdventCalendar2022"],
      title: "【毎日自動更新】新人プログラマ応援 - みんなで新人を育てよう！（2022年04月） LGTMランキング！",
      id: "18dad64ba99aa5a40f95"
    )
  end
end
