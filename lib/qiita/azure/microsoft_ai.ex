defmodule Qiita.Azure.MicrosoftAI do
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
      "【毎日自動更新】Azure AIを活用した機械学習に関する記事を投稿しよう！(2021/5/10–2021/6/9) LGTMランキング！",
      "17f05aad2aff239ab6d2"
    )
  end

  def items do
    start = DateTime.new(~D[2021-05-09], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2021-06-09], ~T[15:00:00.000], "Etc/UTC") |> elem(1)

    Qiita.Api.items("tag:QiitaAzure tag:Azure created:>2021-05-09")
    |> Enum.filter(fn %{"created_at" => created_at} ->
      Timex.between?(created_at, start, ending, inclusive: :start)
    end)
    |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
  end

  defp markdown do
    sorted_items = items()

    """
    https://qiita.com/official-events/5a0932fbeb1443ae1094

    # この記事は
    - [Azure AIを活用した機械学習に関する記事を投稿しよう！(2021/5/10–2021/6/9)](https://qiita.com/official-events/5a0932fbeb1443ae1094)
    - というイベントに参加していると**おもわれる**記事の一覧です
      - 「参加ボタン」を押すのをお忘れなく
      - [tag:QiitaAzure tag:Azure created:>2021-05-09](https://qiita.com/search?q=tag%3AQiitaAzure+tag%3AAzure+created%3A%3E2021-05-09)
    - [QiitaAzure](https://qiita.com/tags/qiitaazure)タグと[Azure](https://qiita.com/tags/azure)タグの両方がついていて、`created_at`が`2021/5/10– 2021/6/10`になっている記事を集めて、LGTM数順に並べています
      - 期間の境界のところは誤りがあるかもしれません
      - そこはご愛嬌ということでお許しください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

    ## QiitaAzure記事投稿キャンペーン
    ### 3月
    https://qiita.com/official-events/a50e99d62dc62d68a9c9

    ### 4月
    https://qiita.com/official-events/22637c675c61a797a24f

    ### 5月
    https://qiita.com/official-events/5a0932fbeb1443ae1094


    # 総件数
    #{Enum.count(sorted_items)}件 :tada::tada::tada:

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{build_table(sorted_items)}

    # AIとAzureと私
    - 私はAIについては全くの門外漢です
      - 以下のビデオや記事に期限までに取り組んで記事を書いてみようとおもいます
      - [Microsoft Ignite](https://myignite.microsoft.com/home)
        - [Intro to Azure AI](https://myignite.microsoft.com/sessions/f30a17a8-e478-4f9e-99cf-913e3f0f3a49?source=sessions)
        - [Getting started with Machine Learning using Python](https://myignite.microsoft.com/sessions/5d21f1ca-199e-401f-aa35-2e51efa518ff?source=sessions)
        - [Getting started with Azure AI](https://myignite.microsoft.com/sessions/061f7404-d668-46bf-b4bd-1ef4cb20b885?source=sessions)
        - [Getting started with Azure AI](https://myignite.microsoft.com/sessions/1f477d45-7b15-4c79-8d08-9e4476d3bda7?source=sessions)
      - [AI エンジニア向けの MICROSOFT LEARN 最先端の AI ソリューションを定義して実装する](https://docs.microsoft.com/ja-jp/learn/roles/ai-engineer)
    - この記事では、いっさいAIなことは書いていませんーーまとめ記事です
      - 私だけの感じ方かもしれません[^1]が、自分が書いた記事が他の方の記事からリンクされると、Qiitaの画面の上のほうで「**あなたの記事にリンクしました**」とお知らせがくることがありますよね
      - あれが私はうれしいです
      - イベントですし、お祭りということで勝手に応援させてください :lgtm::tada::tada::tada::lgtm:

    [^1]: 矢吹丈がそんな言い方を乾物屋の紀ちゃんにするシーンがあって、私は多用しています

    # Wrapping up :lgtm: :qiitan: :lgtm:
    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
      - Raspberry Pi 2が定期的に記事を自動更新しているのであります

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
        "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{
          created_at |> Timex.to_date() |> Date.to_string()
        }|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{likes_count}|\n"
    end)
  end

  def tags(items) do
    tags =
      Enum.flat_map(items, fn %{"tags" => tags} -> tags end)
      |> Enum.reduce(MapSet.new(), fn tag, acc -> MapSet.put(acc, tag) end)

    map =
      tags
      |> Enum.reject(&(&1 == "ネタ" || &1 == "湯婆婆" || &1 == "ポエム"))
      |> Enum.reduce(%{}, fn tag, acc ->
        filtered = Enum.filter(items, &(Map.get(&1, "tags") |> Enum.any?(fn t -> t == tag end)))
        Map.put(acc, tag, filtered)
      end)

    Enum.to_list(map)
    |> Enum.sort_by(fn {tag, _items} -> tag end)
    |> Enum.reduce("", fn {tag, items}, acc ->
      """
      #{acc}

      # #{if(tag == "C#", do: "C Sharp", else: tag)}
      #{
        Enum.map(items, fn %{"title" => title, "url" => url, "user_id" => user_id} ->
          "- [#{title}](#{url}) ーー @#{user_id}"
        end)
        |> Enum.join("\n")
      }
      """
    end)
  end
end
