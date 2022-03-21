defmodule Qiita.Events.Repo do
  def post_markdown(markdown, tags, title, id) do
    Qiita.Api.patch_item(
      markdown,
      false,
      build_tags(tags),
      title,
      id
    )
  end

  def fetch_items(query, start_time, end_time) do
    Qiita.Api.items(query)
    |> Enum.filter(fn %{"created_at" => created_at} ->
      Timex.between?(created_at, start_time, end_time, inclusive: :start)
    end)
  end

  defp build_tags(tags) do
    tags
    |> Enum.map(&%{"name" => &1})
  end
end
