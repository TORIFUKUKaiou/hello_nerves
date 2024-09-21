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
      table_b: table(items, :b)
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
end
