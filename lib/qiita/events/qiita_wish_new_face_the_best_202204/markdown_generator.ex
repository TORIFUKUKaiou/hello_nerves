defmodule Qiita.Events.QiitaWishNewFaceTheBest202204.MarkdownGenerator do
  use Qiita.Events.MarkdownGenerator

  defmodule Data do
    defstruct item_count: 0, tables: {}
  end

  alias Qiita.Events.QiitaWishNewFaceTheBest202204.MarkdownGenerator.Data
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
    https://qiita.com/official-events/3f21c92121aa125807b4

    # この記事は

    「[新人プログラマ応援 - みんなで新人を育てよう！](https://qiita.com/official-events/3f21c92121aa125807b4)」
    キャンペーンの参加記事です。
    [Qiita API v2](https://qiita.com/api/v2/docs)を利用させていただいて、「[新人プログラマ応援 - みんなで新人を育てよう！](https://qiita.com/official-events/3f21c92121aa125807b4)」に参加しているとおもわれる記事を収拾します。
    [新人プログラマ応援](https://qiita.com/tags/%e6%96%b0%e4%ba%ba%e3%83%97%e3%83%ad%e3%82%b0%e3%83%a9%e3%83%9e%e5%bf%9c%e6%8f%b4) タグが設定された記事のみを集めています。[^1]

    [^1]: [新人プログラマ応援](https://qiita.com/tags/%e6%96%b0%e4%ba%ba%e3%83%97%e3%83%ad%e3%82%b0%e3%83%a9%e3%83%9e%e5%bf%9c%e6%8f%b4) タグを付けることは必須ではないようですが、このページではタグが付いている記事のみに絞っています。

    あつまった記事群（データ）にあれこれしてみます。

    - LGTM数順に記事を並べます
    - 投稿者ごとの記事数を集計します
    - 投稿者ごとのLGTM数を集計します
    - tagごとの記事数を集計します
    - tagごとのLGTM数を集計します

    **新人プログラマさんを応援します！**

    「参加ボタン」を押すのをお忘れなく!!!

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

    <font color="purple">$\\huge{新人プログラマさんを応援します🚀}$</font>

    新人プログラマさん向けの記事と侮るなかれ。（これは私自身、自分自身に対して言っています）

    このページに挙がっている[記事の一覧](https://qiita.com/torifukukaiou/items/18dad64ba99aa5a40f95#lgtm%E6%95%B0-confetti_ballmilitary_medalconfetti_ball)は諸先輩方の汗と涙の結晶です。
    記事の中には愛と勇気が詰まっています。
    聞くも涙語るも涙の物語たちです。
    友情、努力、勝利です。
    きっと私自身が学びを得られる良い記事にたくさん出会えるとおもっています。
    **新人プログラマさんを応援する諸先輩方みなさまを応援します！**

    新人プログラマさんのお役にたてれば望外の喜びです。


    ---

    最後に、この記事を自動更新しているプログラムについて補足しておきます。

    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
      - Raspberry Pi 2で動いています。
    - [Elixir](https://elixir-lang.org/)には、データを自在に取り扱える[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールがあります
    - [Elixir](https://elixir-lang.org/)をはじめてみようという方は、[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールの習得からはじめるとよいとおもいます
    - [WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127) :book: の特集２「Elixirによる高速なWeb開発！ 作って学ぶPhoenix」は、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しめる[Phoenix](https://www.phoenixframework.org/)の基礎がぎっしりと詰まっていて、**オススメ**です
    - プログラムは、 https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/events/qiita_wish_new_face_the_best_202204.ex にあります

    https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/events/qiita_wish_new_face_the_best_202204.ex

    ---

    # 追伸

    新人プログラマさん
    各種イベントや勉強会、コミュニティなどにはぜひ参加してみてください。

    上記で紹介した、[Elixir](https://elixir-lang.org/) 言語に興味がある方へのお知らせです。
    朗報です。
    下記のリンク先にあるように、プログラミング言語[Elixir](https://elixir-lang.org/)では、たくさんの勉強会などが開催されています。
    ぜひ思い切って飛び込んでみてください。
    [Elixir](https://elixir-lang.org/)のコミュニティはあなた（新人プログラマさんだけに限りません！）の訪れを**熱烈歓迎**します :older_woman::purple_heart:

    [Elixirイベントカレンダー](https://elixir-jp-calendar.fly.dev/)

    https://elixir-jp-calendar.fly.dev/


    https://qiita.com/official-events/30be12dd14c0aad2c1c2
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
