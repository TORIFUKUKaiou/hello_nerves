defmodule Qiita.Haw.Repo do
  def post_markdown(markdown, tags, title, id) do
    Qiita.Api.patch_item(
      markdown,
      false,
      build_tags(tags),
      title,
      id
    )
  end

  def fetch_items do
    build_query()
    |> Qiita.Api.items()
  end

  defp build_query do
    "org:haw"
  end

  defp build_tags(tags) do
    tags
    |> Enum.map(&%{"name" => &1})
  end
end
