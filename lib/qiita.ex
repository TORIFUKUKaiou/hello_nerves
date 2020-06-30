defmodule Qiita do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [%{"name" => "Elixir"}, %{"name" => "Qiita夏祭り2020_パソナテック"}],
      "【毎日自動更新】QiitaのElixir LGTMランキング！"
    )
  end

  defp markdown do
    items = Qiita.Api.items()

    """
    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # 直近1ヶ月
    #{take(items, Timex.now() |> Timex.shift(days: -30))}

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{take(items, Timex.from_unix(0))}

    # 実行環境
    もちろん[Nerves](https://www.nerves-project.org/) :robot:
    [ソースコード](https://github.com/TORIFUKUKaiou/hello_nerves/pull/34)
    """
  end

  defp take(items, from) do
    items
    |> Enum.filter(fn %{"updated_at" => updated_at} ->
      DateTime.compare(updated_at, from) == :gt
    end)
    |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
    |> Enum.take(20)
    |> table()
  end

  defp table(items) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|タイトル|更新日|LGTM|\n|---|---|---|---|\n", fn {item, index}, acc_string ->
      %{
        "title" => title,
        "likes_count" => likes_count,
        "updated_at" => updated_at,
        "url" => url,
        "user_id" => user_id
      } = item

      acc_string <>
        "|#{index}|[#{title}](#{url})<br>@#{user_id}|#{
          updated_at |> Timex.to_date() |> Date.to_string()
        }|#{likes_count}|\n"
    end)
  end
end
