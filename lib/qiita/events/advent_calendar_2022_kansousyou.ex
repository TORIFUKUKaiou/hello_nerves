defmodule Qiita.Events.AdventCalendar2022Kansousyou do
  alias Qiita.Events.AdventCalendar2022Kansousyou.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "猪木", "闘魂"]
    title = "闘魂Elixir ── 03. 完走賞を目指してみましょう！【自動更新記事】"
    id = "17d55cf896c24b13350e"

    "https://qiita.com/advent-calendar/2022/elixir"
    |> Req.get!()
    |> Map.get(:body)
    |> String.split("encryptedId")
    |> Enum.map(fn s -> Regex.named_captures(~r/"user":{"urlName":"(?<user>.*?)",/, s) end)
    |> Enum.slice(2..-1//1)
    |> Enum.map(fn %{"user" => user} -> user end)
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_user, cnt} -> cnt end, :desc)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
