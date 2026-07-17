defmodule Qiita.Events.AdventCalendar2022Tag.MarkdownGenerator do
  use Qiita.Events.MarkdownGenerator, template_dir: "advent_calendar_2022_tag"

  defp build_bindings(items) do
    filtered_items =
      Enum.filter(items, fn %{"likes_count" => likes_count} -> likes_count >= 7 end)

    [
      item_count: Enum.count(items),
      table_a: table(filtered_items, :a),
      table_b: table(items, :b),
      table_c: table(items, :c),
      table_d: table(items, :d),
      table_e: table(items, :e)
    ]
  end
end
