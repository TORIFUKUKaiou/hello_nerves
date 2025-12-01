defmodule Qiita.Qiita90118093a1b9d319313e do
  @tags ["Elixir", "IoT", "Nerves", "闘魂", "aiではなく人間が書いてます"]
  @title "Raspberry Pi 2 + Nerves、5年間の連続運転で不調に → microSDカード交換で復活"
  @id "90118093a1b9d319313e"

  alias Qiita.Qiita90118093a1b9d319313e.MarkdownGenerator
  alias Qiita.Qiita90118093a1b9d319313e.Repo

  def run do
    today = Date.utc_today()
    base_date = ~D[2025-11-22]

    days_diff = Timex.diff(today, base_date, :days)

    updated_at =
      DateTime.utc_now()
      |> Timex.Timezone.convert("Asia/Tokyo")
      |> Timex.format!("{YYYY}-{0M}-{0D} {h24}:{m}:{s}")

    MarkdownGenerator.generate(days_diff, updated_at)
    |> Repo.post_markdown(@tags, @title, @id)
  end
end
