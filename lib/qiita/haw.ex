defmodule Qiita.Haw do
  @tags ["Elixir", "HAW", "闘魂", "QiitaOrganization", "Qiita"]
  @title "【毎日自動更新】 ハウインターナショナルの記事一覧！"
  @id "64d39eda8a9508a0ec7d"

  alias Qiita.Haw.MarkdownGenerator
  alias Qiita.Haw.Repo

  def run do
    Repo.fetch_items()
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(@tags, @title, @id)
  end
end
