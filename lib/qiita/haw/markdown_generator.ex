defmodule Qiita.Haw.MarkdownGenerator do
  @behaviour Qiita.Events.MarkdownGenerator

  alias Qiita.Events.TableUtils

  @impl true
  def generate(items) do
    items
    |> build_bindings()
    |> build_markdown()
  end

  defp build_bindings(items) do
    [
      item_count: Enum.count(items),
      table_a: table(items, :a),
      table_b: table(items, :b),
      table_c: table(items, :c),
      table_d: table(items, :d)
    ]
  end

  defp build_markdown(bindings) when is_list(bindings) do
    EEx.eval_file(template_path(), bindings)
  end

  defp template_path do
    "#{:code.priv_dir(:hello_nerves)}/qiita_haw/template.md"
  end

  defp table(items, :a) do
    items
    |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
    |> TableUtils.build_table()
  end

  defp table(items, :b) do
    items
    |> Enum.sort_by(fn %{"created_at" => created_at} -> created_at end, {:desc, DateTime})
    |> TableUtils.build_table()
  end

  defp table(items, :c) do
    items
    |> TableUtils.build_table_for_util()
  end

  defp table(items, :d) do
    items
    |> TableUtils.build_table_for_util(
      &TableUtils.aggregate_by_tag/1,
      fn {_, {cnt, likes_count}} -> {cnt, likes_count} end,
      "|No|tag|count|LGTM|",
      false,
      0,
      1
    )
  end
end
