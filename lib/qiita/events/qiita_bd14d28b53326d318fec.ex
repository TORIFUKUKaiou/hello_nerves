defmodule Qiita.Events.QiitaBd14d28b53326d318fec do
  alias Qiita.Events.QiitaBd14d28b53326d318fec.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:さくらのAI"
    start_time = DateTime.new(~D[2026-07-13], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2026-08-25], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["さくらのAI", "Elixir", "Nerves", "claudecode", "闘魂"]
    title = "【毎日自動更新】さくらのAI Engine 3,000リクエスト使い切りチャレンジ いいねランキング！"
    id = "c4f654f0dad56e5da409"

    Repo.fetch_items(query, start_time, end_time)
    |> Enum.filter(fn item -> item["posting_campaign_uuid"] == "bd14d28b53326d318fec" end)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
