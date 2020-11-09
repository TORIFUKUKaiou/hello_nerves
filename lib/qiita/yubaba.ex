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
      - `"title:湯婆婆 OR tag:湯婆婆"`で検索しています
      - LGTM数順に並べています

    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{build_table(sorted_items)}

    # Wrapping up :lgtm: :qiitan: :lgtm:
    - @momeemtさんの[記事](https://qiita.com/momeemt/items/c4163f71a9b2d4408935#%E6%9C%80%E5%BE%8C%E3%81%AB)にある通り、入力を受け取ってそれを変換して出力するというのは、プログラミングの基本ーー大きく言うと、つまり`湯婆婆`はこれからの`"Hello, World"`における例題の一つのような気がしています
      - 将棋の[原田泰夫](https://ja.wikipedia.org/wiki/%E5%8E%9F%E7%94%B0%E6%B3%B0%E5%A4%AB)九段が提唱された**三手の読み（こうやる、こう来る、そこでこう指す）**に通じるものがあるような気がします
      - [令和のHello World!](https://qiita.com/everylittle/items/aae58c241194c0e5f515#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)との呼び声も！(@everylittle さん)
    - 令和２年なのに未だにRaspberry Pi 2しかもっていない私の虎の子のRaspberry Pi 2が毎日自動更新しております
      - [コミット](https://github.com/TORIFUKUKaiou/hello_nerves/pull/47/commits/5e0ea0f3fdaac3d5ab1930b6e99f10ae5a688851)
    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)というナウでヤングなcoolなすごいIoTフレームワークを使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
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
