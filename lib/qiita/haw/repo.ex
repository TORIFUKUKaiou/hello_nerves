defmodule Qiita.Haw.Repo do
  @users ~w(sgtakeru tsuruoka91 mnishiguchi torifukukaiou t_kamiya78 haw_ohnuma Erga-mion)
  @organization_url_name "haw"

  def post_markdown(markdown, tags, title, id) do
    Qiita.Api.patch_item(
      markdown,
      true,
      build_tags(tags),
      title,
      id
    )
  end

  def fetch_items do
    build_query()
    |> Qiita.Api.items()
    |> Enum.filter(fn item -> Map.get(item, "organization_url_name") == @organization_url_name end)
  end

  defp build_query do
    @users
    |> Enum.map(&"user:#{&1}")
    |> Enum.join(" or ")
  end

  defp build_tags(tags) do
    tags
    |> Enum.map(&%{"name" => &1})
  end
end
