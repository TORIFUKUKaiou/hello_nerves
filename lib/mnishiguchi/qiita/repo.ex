defmodule Mnishiguchi.Qiita.Repo do
  def put_markdown(markdown) do
    Qiita.Api.patch_item(
      markdown,
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "delika"},
        %{"name" => "Qiitadelika"},
        %{"name" => "40代駆け出しエンジニア"},
        %{"name" => "AdventCalendar2022"}
      ],
      "【毎日自動更新】データに関する記事を書こう！ LGTMランキング！",
      "b10fa94764aaaa2c6db1"
    )
  end

  def fetch_items(start_time, end_time) do
    Qiita.Api.items("tag:Qiitadelika OR tag:delika")
    |> Enum.filter(fn %{"created_at" => created_at} ->
      Timex.between?(created_at, start_time, end_time, inclusive: :start)
    end)
  end
end
