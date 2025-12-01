defmodule Qiita.Qiita90118093a1b9d319313e.Repo do
  def post_markdown(markdown, tags, title, id) do
    Qiita.Api.patch_item(
      markdown,
      false,
      build_tags(tags),
      title,
      id
    )
  end

  defp build_tags(tags) do
    tags
    |> Enum.map(&%{"name" => &1})
  end
end
