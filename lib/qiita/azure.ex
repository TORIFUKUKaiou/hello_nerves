defmodule Qiita.Azure do
  defmacro __using__(opts) do
    item_id = Keyword.get(opts, :item_id)
    title = Keyword.get(opts, :title)
    event_title = Keyword.get(opts, :event_title)
    event_url = Keyword.get(opts, :event_url)
    description = Keyword.get(opts, :description)
    start = Keyword.get(opts, :start)
    ending = Keyword.get(opts, :ending)

    quote do
      def run do
        Qiita.Api.patch_item(
          markdown(),
          false,
          [
            %{"name" => "Elixir"},
            %{"name" => "QiitaAzure"},
            %{"name" => "Azure"},
            %{"name" => "Nerves"}
          ],
          unquote(title),
          unquote(item_id)
        )
      end

      def items do
        start = DateTime.new(unquote(start), ~T[15:00:00.000], "Etc/UTC") |> elem(1)
        ending = DateTime.new(unquote(ending), ~T[15:00:00.000], "Etc/UTC") |> elem(1)

        Qiita.Api.items("tag:QiitaAzure tag:Azure created:>#{unquote(start) |> Date.to_string()}")
        |> Enum.filter(fn %{"created_at" => created_at} ->
          Timex.between?(created_at, start, ending, inclusive: :start)
        end)
        |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
      end

      defp markdown do
        sorted_items = items()

        """
        #{unquote(event_url)}

        # この記事は
        - [#{unquote(event_title)}](#{unquote(event_url)})
        - というイベントに参加していると**おもわれる**記事の一覧です
          - 「参加ボタン」を押すのをお忘れなく
        - [QiitaAzure](https://qiita.com/tags/qiitaazure)タグと[Azure](https://qiita.com/tags/azure)タグの両方がついていて、`created_at`が募集期間内になっている記事を集めて、LGTM数順に並べています
          - 期間の境界のところは誤りがあるかもしれません
          - そこはご愛嬌ということでお許しください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

        # 総件数
        #{Enum.count(sorted_items)}件 :tada::tada::tada:

        # 全期間 :confetti_ball::military_medal::confetti_ball:
        #{build_table(sorted_items)}

        #{unquote(description)}

        ## QiitaAzure記事投稿キャンペーン
        ### 3月
        https://qiita.com/official-events/a50e99d62dc62d68a9c9

        ### 4月
        https://qiita.com/official-events/22637c675c61a797a24f

        ### 5月
        https://qiita.com/official-events/5a0932fbeb1443ae1094

        ### 6月
        https://qiita.com/official-events/885e4031d03c787eceab

        # Wrapping up :lgtm: :qiitan: :lgtm:
        - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
          - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
          - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
          - Raspberry Pi 2が定期的に記事を自動更新しているのであります
        - [ソースコード TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)

        # 最後の最後に
        ## [Elixir](https://elixir-lang.org/)ってなによ:interrobang:という方へ

        ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/601aeb87-9d1d-6a9d-b30b-338507dc593e.png)

        - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 2020/12/26時点くらいのスクリーンショット
        - [Elixir](https://elixir-lang.org/)についてもっと知りたい方は下記の本:books:をオススメします
            - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
            - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
        - [elixir.jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)の`#autoracex`というところに私は入り浸っておりますのでお気軽にお声がけください
        - [勉強会が頻繁に行われています](https://twitter.com/piacere_ex/status/1364109880362115078)
            - 私がよく参加している勉強会です
            - [autoracex](https://autoracex.connpass.com/) 【毎週土曜〜月曜】 主催
            - [Sapporo.beam](https://sapporo-beam.connpass.com)　　【毎週水曜】
            - [OkazaKirin.beam](https://okazakirin-beam.connpass.com)　【毎週木曜】
            - [fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com)　【毎月2～3回】
            - [NervesJP](https://nerves-jp.connpass.com/) 　【毎月1回】

        ![EsvA7uQU0AEoTuX.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2ad87109-2684-1605-e1dc-457b835b8c15.jpeg)

        (@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)
        """
      end

      defp build_table(items) do
        Enum.with_index(items, 1)
        |> Enum.reduce(
          "|No|title|created_at|updated_at|LGTM|\n|---|---|---|---|---:|\n",
          fn {item, index}, acc_string ->
            %{
              "title" => title,
              "likes_count" => likes_count,
              "created_at" => created_at,
              "updated_at" => updated_at,
              "url" => url,
              "user_id" => user_id
            } = item

            acc_string <>
              "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{
                created_at |> Timex.to_date() |> Date.to_string()
              }|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{
                Number.Delimit.number_to_delimited(likes_count, precision: 0)
              }|\n"
          end
        )
      end
    end
  end
end
