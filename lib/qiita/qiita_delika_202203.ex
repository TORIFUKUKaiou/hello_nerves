defmodule Qiita.Qiitadelika202203 do
  def run do
    Qiita.Api.patch_item(
      markdown(),
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

  def items do
    start = DateTime.new(~D[2022-03-13], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2022-04-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    Qiita.Api.items("tag:Qiitadelika OR tag:delika")
    |> Enum.filter(fn %{"created_at" => created_at} ->
      Timex.between?(created_at, start, ending, inclusive: :start)
    end)
  end

  def markdown do
    items = items()

    sorted_items =
      Enum.sort_by(items, fn %{"likes_count" => likes_count} -> likes_count end, :desc)

    """
    https://qiita.com/official-events/30be12dd14c0aad2c1c2

    # この記事は

    「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」
    キャンペーンの参加記事です。
    テーマ2『データに関する記事を書こう！』に参加しています。

    [Qiita API v2](https://qiita.com/api/v2/docs)を利用させていただいて、「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」に参加しているとおもわれる記事を収拾します。
    あつまった記事群（データ）にあれこれしてみます。

    - LGTM数順に記事を並べます
    - 投稿者ごとの記事数を集計します
    - 投稿者ごとのLGTM数を集計します

    **面白い結果がでること**間違いなしです。
    だって、キャンペーン自体が面白いのですもの！！！

    「参加ボタン」を押すのをお忘れなく!!!
    参考: [本ページの「参加する」ボタンをクリックしていること](https://qiita.com/kaizen_nagoya/items/03500a8137e446893c97#%E6%9C%AC%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%AE%E5%8F%82%E5%8A%A0%E3%81%99%E3%82%8B%E3%83%9C%E3%82%BF%E3%83%B3%E3%82%92%E3%82%AF%E3%83%AA%E3%83%83%E3%82%AF%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%93%E3%81%A8)

    ---

    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # LGTM数 :confetti_ball::military_medal::confetti_ball:
    #{build_table(sorted_items)}

    # 投稿者ごとの記事数とLGTM数
    #{build_table_for_authors(sorted_items)}

    ---

    # Wrapping up :lgtm: :qiitan: :lgtm:

    いかがでしょうか。
    **面白い結果**がでましたよね！！！

    般若心経の最初に「観自在菩薩」とあります。
    データにおいてもまず「観」ることが出発点なのだとおもいます。
    「観」る、観察する、つまり気づきを出発点として、自在にデータを分析をすることでその終着として、**面白い結果**が得られるのです。
    みえる形にするにはまず集めることが必要です。
    [イベントの概要](https://qiita.com/official-events/30be12dd14c0aad2c1c2#%E6%A6%82%E8%A6%81)に記載されている「**データの民主化**」に激しく同意いたします。

    ---

    最後に、この記事を自動更新しているプログラムについて補足しておきます。

    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
    - [Elixir](https://elixir-lang.org/)には、データを自在に取り扱える[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールがあります
    - [Elixir](https://elixir-lang.org/)をはじめてみようという方は、[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールの習得からはじめるとよいとおもいます
    - [WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127) :book: の特集２「Elixirによる高速なWeb開発！ 作って学ぶPhoenix」は、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しめる[Phoenix](https://www.phoenixframework.org/)の基礎がぎっしりと詰まっていて、**オススメ**です
    - プログラムは、 https://github.com/TORIFUKUKaiou/hello_nerves/blob/f56229d372703d44819062bf81f8633905942a8a/lib/qiita/qiita_delika_202203.ex にあります

    https://github.com/TORIFUKUKaiou/hello_nerves/blob/f56229d372703d44819062bf81f8633905942a8a/lib/qiita/qiita_delika_202203.ex
    """
  end

  defp build_table(items) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|title|created_at|updated_at|LGTM|\n|---|---|---|---|---:|\n", fn {item,
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
        "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{created_at |> Timex.to_date() |> Date.to_string()}|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{Number.Delimit.number_to_delimited(likes_count, precision: 0)}|\n"
    end)
  end

  def build_table_for_authors(items) do
    aggregate_by_author(items)
    |> Map.to_list()
    |> Enum.sort_by(fn {_, {cnt, _}} -> cnt end, :desc)
    |> Enum.with_index(1)
    |> Enum.reduce("|No|user|count|LGTM|\n|---|---|---:|---:|\n", fn {{user_id,
                                                                       {cnt, likes_count}},
                                                                      index},
                                                                     acc_string ->
      acc_string <>
        "|#{index}|@#{user_id}|#{Number.Delimit.number_to_delimited(cnt, precision: 0)}|#{Number.Delimit.number_to_delimited(likes_count, precision: 0)}|\n"
    end)
  end

  def aggregate_by_author(items) do
    items
    |> Enum.reduce(%{}, fn %{"user_id" => user_id, "likes_count" => likes_count}, acc ->
      Map.update(acc, user_id, {1, likes_count}, fn {cnt, old_likes_count} ->
        {cnt + 1, old_likes_count + likes_count}
      end)
    end)
  end
end
