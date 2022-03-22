defmodule Qiita.Events.Qiitadelika202203.MarkdownGenerator do
  use Qiita.Events.MarkdownGenerator

  defmodule Data do
    defstruct item_count: 0, tables: {}
  end

  alias Qiita.Events.Qiitadelika202203.MarkdownGenerator.Data
  alias Qiita.Events.TableUtils

  @impl true
  def generate(items) do
    items
    |> sort_items()
    |> build_data()
    |> build_markdown()
  end

  defp sort_items(items) do
    Enum.sort_by(items, fn %{"likes_count" => likes_count} -> likes_count end, :desc)
  end

  defp build_data(items) do
    %Data{
      item_count: Enum.count(items),
      tables: {
        table(items, :a),
        table(items, :b),
        table(items, :c),
        table(items, :d),
        table(items, :e)
      }
    }
  end

  defp build_markdown(%Data{
         item_count: item_count,
         tables: {table_a, table_b, table_c, table_d, table_e}
       }) do
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
    - tagごとの記事数を集計します
    - tagごとのLGTM数を集計します

    **面白い結果がでること**間違いなしです。
    だって、キャンペーン自体が面白いのですもの！！！

    「参加ボタン」を押すのをお忘れなく!!!
    参考: [本ページの「参加する」ボタンをクリックしていること](https://qiita.com/kaizen_nagoya/items/03500a8137e446893c97#%E6%9C%AC%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%AE%E5%8F%82%E5%8A%A0%E3%81%99%E3%82%8B%E3%83%9C%E3%82%BF%E3%83%B3%E3%82%92%E3%82%AF%E3%83%AA%E3%83%83%E3%82%AF%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%93%E3%81%A8)

    ---

    # 総件数
    #{item_count}件 :tada::tada::tada:

    # LGTM数 :confetti_ball::military_medal::confetti_ball:
    #{table_a}

    # 投稿者ごとの記事数とLGTM数
    #{table_b}

    # 投稿者ごとのLGTM数と記事数
    #{table_c}

    # タグごとの記事数とLGTM数
    #{table_d}

    # タグごとのLGTM数と記事数
    #{table_e}

    ---

    # Wrapping up :lgtm: :qiitan: :lgtm:

    いかがでしょうか。
    **面白い結果**がでましたよね！！！
    いやぁ、データって本当にいいもんですね～ :movie_camera:

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
    - プログラムは、 https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/qiita_delika_202203.ex にあります

    https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/qiita_delika_202203.ex
    """
  end

  defp table(items, :a) do
    TableUtils.build_table(items)
  end

  defp table(items, :b) do
    TableUtils.build_table_for_util(items)
  end

  defp table(items, :c) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_author/1,
      fn {_, {_, likes_cnt}} -> likes_cnt end,
      "|No|user|LGTM|count|",
      true,
      1,
      0
    )
  end

  defp table(items, :d) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_tag/1,
      fn {_, {cnt, _}} -> cnt end,
      "|No|tag|count|LGTM|",
      false,
      0,
      1
    )
  end

  defp table(items, :e) do
    TableUtils.build_table_for_util(
      items,
      &TableUtils.aggregate_by_tag/1,
      fn {_, {_, likes_cnt}} -> likes_cnt end,
      "|No|tag|LGTM|count|",
      false,
      1,
      0
    )
  end
end
