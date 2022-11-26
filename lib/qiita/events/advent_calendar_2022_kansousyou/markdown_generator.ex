defmodule Qiita.Events.AdventCalendar2022Kansousyou.MarkdownGenerator do
  @behaviour Qiita.Events.MarkdownGenerator

  @impl true
  def generate(list) do
    list
    |> build_bindings()
    |> build_markdown()
  end

  defp build_bindings(list) do
    [
      result: inspect(list, pretty: true),
      now: DateTime.now!("Etc/UTC") |> DateTime.add(9 * 60 * 60) |> DateTime.to_string(),
      count: list |> Enum.filter(fn {_, cnt} -> cnt >= 25 end) |> Enum.count()
    ]
  end

  defp build_markdown(bindings) when is_list(bindings) do
    EEx.eval_file(template_path(), bindings)
  end

  defp template_path do
    "#{:code.priv_dir(:hello_nerves)}/advent_calendar_2022_kansousyou/template.md"
  end
end
