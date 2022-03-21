defmodule Qiita.Events.Main do
  import Qiita.Events.Repo

  def run(query, start_time, end_time, mod, tags, title, id) do
    fetch_items(query, start_time, end_time)
    |> mod.generate()
    |> post_markdown(tags, title, id)
  end
end
