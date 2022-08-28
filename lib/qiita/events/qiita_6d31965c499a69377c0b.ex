defmodule Qiita.Events.Qiita6d31965c499a69377c0b do
  alias Qiita.Events.Qiita6d31965c499a69377c0b.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:個人開発 or tag:読書感想文"
    start_time = DateTime.new(~D[2022-08-14], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-09-16], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "個人開発", "読書感想文", "40代駆け出しエンジニア", "AdventCalendar2022"]
    title = "【毎日自動更新】エンジニア夏休み企画！～自由研究や読書感想文を発表しよう～ LGTMランキング！"
    id = "a5cfd648b4e477a2f131"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
