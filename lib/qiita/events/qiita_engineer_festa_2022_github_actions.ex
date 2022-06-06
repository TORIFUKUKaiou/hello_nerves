defmodule Qiita.Events.QiitaEngineerFesta2022GitHubActions do
  alias Qiita.Events.QiitaEngineerFesta2022GitHubActions.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_GitHub tag:GitHubActions"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_GitHub", "GitHubActions"]
    title = "【毎日自動更新】GitHub Actionsの自分流の使い方をシェアしよう LGTMランキング！"
    id = "a1edaacb8d0023873b6d"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
