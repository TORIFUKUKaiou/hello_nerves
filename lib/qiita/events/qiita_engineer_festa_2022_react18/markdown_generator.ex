defmodule Qiita.Events.QiitaEngineerFesta2022React18.MarkdownGenerator do
  @behaviour Qiita.Events.MarkdownGenerator

  alias Qiita.Events.TableUtils

  @impl true
  def generate(items) do
    items
    |> sort_items()
    |> build_bindings()
    |> build_markdown()
  end

  defp sort_items(items) do
    Enum.sort_by(items, fn %{"likes_count" => likes_count} -> likes_count end, :desc)
  end

  defp build_bindings(items) do
    [
      item_count: Enum.count(items),
      table_a: table(items, :a),
      table_b: table(items, :b),
      table_c: table(items, :c),
      table_d: table(items, :d),
      table_e: table(items, :e)
    ]
  end

  defp build_markdown(bindings) when is_list(bindings) do
    EEx.eval_file(template_path(), bindings)
  end

  defp template_path do
    "#{:code.priv_dir(:hello_nerves)}/qiita_engineer_festa_2022_react18/template.md"
  end

  defp table(items, :a) do
    TableUtils.build_table(items)
  end

  defp table(items, :b) do
    TableUtils.build_table_for_util(items)
  end

  defp table(items, :c) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_author/1,
      fn {_, {_, likes_cnt}} -> likes_cnt end,
      "|No|user|LGTM|count|",
      true,
      1,
      0
    )
  end

  defp table(items, :d) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_tag/1,
      fn {_, {cnt, _}} -> cnt end,
      "|No|tag|count|LGTM|",
      false,
      0,
      1
    )
  end

  defp table(items, :e) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_tag/1,
      fn {_, {_, likes_cnt}} -> likes_cnt end,
      "|No|tag|LGTM|count|",
      false,
      1,
      0
    )
  end
end
