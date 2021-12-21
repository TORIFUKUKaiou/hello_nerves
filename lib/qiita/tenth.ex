defmodule Qiita.Tenth do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "Qiita10th_未来"},
        %{"name" => "Qiita10th_過去"},
        %{"name" => "Nerves"}
      ],
      "Qiita 10周年記念イベント LGTMランキング！",
      "69980bf263d20eab1988"
    )
  end

  @events %{
    "https://qiita.com/official-events/1e99fc384200c38548fd" => [
      "Qiita10th_過去"
    ],
    "https://qiita.com/official-events/12fc7bacec894d33a981" => [
      "Qiita10th_未来"
    ]
  }

  defp items do
    @events
    |> Enum.reduce(%{}, fn {key, tags}, acc ->
      items =
        build_tags(tags)
        |> Qiita.Api.items()
        |> Enum.filter(&between?/1)
        |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)

      Map.merge(acc, %{key => items})
    end)
  end

  defp between?(%{"created_at" => created_at}) do
    start = DateTime.new(~D[2021-09-08], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2021-09-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    Timex.between?(created_at, start, ending, inclusive: :start)
  end

  defp build_tags(tags) do
    Enum.map(tags, &"tag:#{&1}")
    |> Enum.join(" ")
  end

  defp sum_of_likes_count(items) do
    items
    |> Map.values()
    |> List.flatten()
    |> Enum.map(fn %{"likes_count" => likes_count} -> likes_count end)
    |> Enum.sum()
  end

  defp markdown do
    items = items()

    """
    https://qiita.com/official-events/1e99fc384200c38548fd

    https://qiita.com/official-events/12fc7bacec894d33a981

    # この記事は
    - 2021年9月9日から9月30日まで開催されている「[Qiita 10周年記念イベント - 10年前の自分に伝えたい、勉強しておきたかった技術](https://qiita.com/official-events/1e99fc384200c38548fd)」およびに「[Qiita 10周年記念イベント - 10年後のために今勉強しておきたい技術](https://qiita.com/official-events/12fc7bacec894d33a981)」に投稿されたと**おもわれる**記事をLGTM数順に並べたものです
      - 「参加ボタン」を押すのをお忘れなく
    - そして、この記事自身がイベントに参加しているという欲張りな記事です
    - 私だけの感じ方かもしれません[^1]が、自分が書いた記事が他の方の記事からリンクされると、Qiitaの画面の上のほうで「あなたの記事にリンクしました」とお知らせがくることがありますよね
      - あれが私はうれしいです
      - イベントですし、お祭りということで勝手に応援させてください :lgtm::tada::tada::tada::lgtm:

    [^1]: 矢吹丈がそんな言い方を乾物屋の紀ちゃんにするシーンがあって、私は多用しています

    # 総件数
    #{items |> Map.values() |> List.flatten() |> Enum.count()}件 :tada::tada::tada:

    # 総LGTM数 :lgtm::lgtm::lgtm::lgtm::lgtm:
    #{sum_of_likes_count(items) |> Number.Delimit.number_to_delimited(precision: 0)} :rocket::rocket::rocket:

    # ランキング〜〜〜 :crown::crown::crown::crown::crown:
    #{["https://qiita.com/official-events/1e99fc384200c38548fd", "https://qiita.com/official-events/12fc7bacec894d33a981"] |> Enum.map(fn url -> "#{url}\n\n#{Map.get(items, url) |> build_table()}\n" end) |> Enum.join("---\n")}

    # イベント参加記事
    > 10年前に勉強しておきたかったと思えるような技術
    > 現在勉強している技術

    - [Elixir](https://elixir-lang.org/)です。
      - Webアプリケーションつくるなら[Phoenix](https://phoenixframework.org/)
      - IoTやるなら[Nerves](https://www.nerves-project.org/)
    - [Elixir](https://elixir-lang.org/)の誕生は、正確には2012年ということでQiitaさんのいっこ後輩です。
    - 四捨五入して10年ってことで出た当時から知っておきたかったと思っています。
    - さらにいま私が現在勉強している技術はとにかく[Elixir](https://elixir-lang.org/)にからんだものです。
    - 何が良いって、とにかく私は好きなんです。好きなものは好きなのです。これ以上の理由が必要でしょうか。
    - <font color="purple">$\\huge{I　was　born　to　love　Elixir}$</font>

    ## Elixirプログラム例

    - [Elixir](https://elixir-lang.org/)をまだ書いたことがない方のために、[Elixir](https://elixir-lang.org/)のプログラム例を示します

    ```elixir:hello.exs
    Mix.install([
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"}
    ])

    "https://qiita.com/api/v2/items?query=tag:Elixir"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.map(& &1["title"])
    |> IO.inspect()
    ```

    - Elixir 1.12以上をインストールして、`elixir hello.exs`で実行できます
      - 深く入り込む方には、[asdf](https://github.com/asdf-vm/asdf)でバージョン切り替えができるようにすることをオススメします
      - とりあえずまず試してみたいという方へ
          - macOS: `brew install elixir`
          - Windows: https://elixir-lang.org/install.html#windows こちらのインストーラからインストール
          - Docker: `docker run -it --rm elixir /bin/bash`
    - [Qiita API v2](https://qiita.com/api/v2/docs)を使って、`Elixir`タグがついた記事を取得しています
      - この自動更新記事はこのAPIを使わせていただいています
    - 以下、これから[Elixir](https://elixir-lang.org/)をはじめてみようという方のためにいくつかオススメ情報をお示しします

    ## 書籍 :book:
    - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
      - 定番です
    - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
      - もし「[プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)」を難しいと感じた方はこちらからはじめてみることをオススメします
      - 「[プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)」で十分という方にももちろんオススメです
          - 「[プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)」ではさらっとした説明で進んでいるところの詳しい解説などがあって新しい発見がきっとあることでしょう

    ## コミュニティ
    - [Slack elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)
      - マヂやさしい人ばっかりのコミュニティです
      - ぜひご参加ください！
    - [connpass](https://connpass.com/)でさがしてみてください

    <blockquote class="twitter-tweet"><p lang="ja" dir="ltr">うわぁ、色々やっちまった…😱<br><br>OkazakirinBeamとautoracexのロゴを載せ忘れてた、スンマセン🙇‍♂️<br><br>あと、自ら主催してるEDI（Elixir Digitalizaiton Implementors）をスッカリ忘れてた、あはは…😅<br><br>…という訳で、修正版です💁‍♂️ <a href="https://t.co/Zx767n266U">pic.twitter.com/Zx767n266U</a></p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1354388393690419208?ref_src=twsrc%5Etfw">January 27, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

    # Wrapping up :lgtm: :qiitan: :lgtm:
    - [Qiita 10周年記念イベント](https://qiita.com/qiita10th)でたくさんの記事と出会えることを楽しみにしております :tada::tada::tada:
    - 自動更新は、令和２年なのに未だに我が家の主力Raspberry Pi 2の上でイゴかしている[Nerves](https://www.nerves-project.org/)アプリが毎日更新しております
      - [TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
    - 「10年前に勉強しておきたかったと思えるような技術」、「現在勉強している技術」ーー過去から未来、私にとってそれは[Elixir](https://elixir-lang.org/)であります
    - Enjoy [Elixir](https://elixir-lang.org/)!!! :rocket::rocket::rocket:
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
end
