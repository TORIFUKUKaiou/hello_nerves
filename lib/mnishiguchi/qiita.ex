defmodule Mnishiguchi.Qiita do
  @moduledoc false

  import Mnishiguchi.Qiita.Repo
  alias Mnishiguchi.Qiita.Markdown

  def run(start_time, end_time) do
    fetch_items(start_time, end_time)
    |> Markdown.generate()
    |> put_markdown()
  end
end
