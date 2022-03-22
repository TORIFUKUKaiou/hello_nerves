defmodule Qiita.Events.Qiitadelika202203 do
  alias Qiita.Events.Qiitadelika202203.MarkdownGenerator

  def run do
    start = DateTime.new(~D[2022-03-13], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2022-04-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    MarkdownGenerator.run(
      "tag:Qiitadelika OR tag:delika",
      start,
      ending,
      ["Elixir", "delika", "Qiitadelika", "40代駆け出しエンジニア", "AdventCalendar2022"],
      "【毎日自動更新】データに関する記事を書こう！ LGTMランキング！",
      "b10fa94764aaaa2c6db1"
    )
  end
end
