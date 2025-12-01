defmodule Qiita.Qiita90118093a1b9d319313e.MarkdownGenerator do
  def generate(days_diff, updated_at) do
    build_bindings(days_diff, updated_at)
    |> build_markdown()
  end

  defp build_bindings(days_diff, updated_at) do
    [
      days_diff: days_diff,
      updated_at: updated_at
    ]
  end

  defp build_markdown(bindings) when is_list(bindings) do
    EEx.eval_file(template_path(), bindings)
  end

  defp template_path do
    "#{:code.priv_dir(:hello_nerves)}/qiita_90118093a1b9d319313e/template.md"
  end
end
