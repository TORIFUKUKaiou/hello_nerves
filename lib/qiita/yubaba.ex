defmodule Qiita.Yubaba do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "ネタ"},
        %{"name" => "湯婆婆"}
      ],
      "【毎日自動更新】湯婆婆 LGTMランキング！",
      "c8361231cdc56e493245"
    )
  end

  defp markdown do
    items = Qiita.Api.items("title:湯婆婆 OR tag:湯婆婆")

    sorted_items =
      Enum.sort_by(items, fn %{"likes_count" => likes_count} -> likes_count end, :desc)

    """
    # この記事は
    - @Nemesis さんの[Javaで湯婆婆を実装してみる](https://qiita.com/Nemesis/items/c7192a7c510788d2cba2)よりはじまった「湯婆婆」関連記事のリンク集です
      - LGTM数順に並べています
    - 令和２年なのに未だにRaspberry Pi 2しかもっていない私の虎の子のRaspberry Pi 2が毎日自動更新しております
      - [コミット](https://github.com/TORIFUKUKaiou/hello_nerves/pull/47/commits/5e0ea0f3fdaac3d5ab1930b6e99f10ae5a688851)
    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)というナウでヤングなcoolなすごいIoTフレームワークを使っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)

    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{build_table(sorted_items)}
    """
  end

  defp build_table(items) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|title|created_at|updated_at|LGTM|\n|---|---|---|---|---|\n", fn {item,
                                                                                         index},
                                                                                        acc_string ->
      %{
        "title" => title,
        "likes_count" => likes_count,
        "created_at" => created_at,
        "updated_at" => updated_at,
        "url" => url,
        "user_id" => user_id
      } = item

      acc_string <>
        "|#{index}|[#{title}](#{url})<br>@#{user_id}|#{
          created_at |> Timex.to_date() |> Date.to_string()
        }|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{likes_count}|\n"
    end)
  end
end
