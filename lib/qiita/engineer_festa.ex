defmodule Qiita.EngineerFesta do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "Qiitaエンジニアフェスタ_開発環境"},
        %{"name" => "Nerves"}
      ],
      "Qiitaエンジニアフェスタ2021 LGTMランキング！",
      "949ff6d59ffeeec0cd51"
    )
  end

  @events %{
    "https://qiita.com/official-events/89fd4ad3c24d7882117d" => [
      "Qiitaエンジニアフェスタ_開発環境"
    ],
    "https://qiita.com/official-events/be8c5ab5a9ddf90055cd" => [
      "Qiitaエンジニアフェスタ_ブラウザ選手権"
    ],
    "https://qiita.com/official-events/339b6440dbd578f4f66f" => [
      "Qiitaエンジニアフェスタ_Dockerシステム構成"
    ],
    "https://qiita.com/official-events/d409f91fc8b9b44cefb4" => [
      "Qiitaエンジニアフェスタ_技術書"
    ],
    "https://qiita.com/official-events/e55396f286b3e2b85a62" => [
      "Qiitaエンジニアフェスタ_自社技術スタック"
    ],
    "https://qiita.com/official-events/5fcd3867b233a9228fd0" => [
      "Qiitaエンジニアフェスタ_Auth0",
      "Auth0"
    ],
    "https://qiita.com/official-events/846e19ec9af76ca9c940" => [
      "Qiitaエンジニアフェスタ_SORACOM",
      "SORACOM"
    ],
    "https://qiita.com/official-events/64ff6ba4e653a822fce9" => [
      "Qiitaエンジニアフェスタ_DirectCloud-BOX"
    ],
    "https://qiita.com/official-events/21bbb48549a4a68172a4" => ["Qiitaエンジニアフェスタ_TrendMicro"],
    "https://qiita.com/official-events/8d3820474c1143e88801" => [
      "Qiitaエンジニアフェスタ_StaticWebApps",
      "Azure"
    ],
    "https://qiita.com/official-events/aa53d801cf3d9d578e18" => [
      "Qiitaエンジニアフェスタ_Bitrise",
      "Bitrise"
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

  defp top_ten(items) do
    items
    |> Map.values()
    |> List.flatten()
    |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
    |> Enum.take(10)
  end

  defp between?(%{"created_at" => created_at}) do
    start = DateTime.new(~D[2021-06-30], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    ending = DateTime.new(~D[2021-08-25], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    Timex.between?(created_at, start, ending, inclusive: :start)
  end

  defp build_tags(tags) do
    Enum.map(tags, &"tag:#{&1}")
    |> Enum.join(" ")
  end

  defp markdown do
    items = items()

    """
    https://qiita.com/official-campaigns/engineer-festa/2021

    # この記事は
    - 2021年7月1日から8月25日まで開催されている[Qiitaエンジニアフェスタ2021](https://qiita.com/official-campaigns/engineer-festa/2021)に投稿されたと**おもわれる**記事をLGTM数順に並べたものです
      - 「参加ボタン」を押すのをお忘れなく
    - 私だけの感じ方かもしれません[^1]が、自分が書いた記事が他の方の記事からリンクされると、Qiitaの画面の上のほうで「あなたの記事にリンクしました」とお知らせがくることがありますよね
      - あれが私はうれしいです
      - イベントですし、お祭りということで勝手に応援させてください :lgtm::tada::tada::tada::lgtm:

    [^1]: 矢吹丈がそんな言い方を乾物屋の紀ちゃんにするシーンがあって、私は多用しています

    # 総件数
    #{items |> Map.values() |> List.flatten() |> Enum.count()}件 :tada::tada::tada:

    # 総合賞
    https://qiita.com/official-campaigns/engineer-festa/2021
    > エンジニアフェスタ全体で最も多くのLGTMがついた記事を投稿したユーザーに対して総合賞を設けています。

    #{items |> top_ten() |> build_table()}

    # スポンサー企業のテーマ

    #{
      [
        "https://qiita.com/official-events/5fcd3867b233a9228fd0",
        "https://qiita.com/official-events/846e19ec9af76ca9c940",
        "https://qiita.com/official-events/64ff6ba4e653a822fce9",
        "https://qiita.com/official-events/21bbb48549a4a68172a4",
        "https://qiita.com/official-events/8d3820474c1143e88801",
        "https://qiita.com/official-events/aa53d801cf3d9d578e18"
      ]
      |> Enum.map(fn url ->
        "#{url}\n\n#{Map.get(items, url) |> build_table()}\n"
      end)
      |> Enum.join("---\n")
    }

    日本マイクロソフト株式会社 7/22テーマ公開予定 (Coming Soon)

    # Qiita運営テーマ
    #{
      [
        "https://qiita.com/official-events/89fd4ad3c24d7882117d",
        "https://qiita.com/official-events/be8c5ab5a9ddf90055cd",
        "https://qiita.com/official-events/339b6440dbd578f4f66f",
        "https://qiita.com/official-events/d409f91fc8b9b44cefb4",
        "https://qiita.com/official-events/e55396f286b3e2b85a62"
      ]
      |> Enum.map(fn url ->
        "#{url}\n\n#{Map.get(items, url) |> build_table()}\n"
      end)
      |> Enum.join("---\n")
    }

    # Wrapping up :lgtm: :qiitan: :lgtm:
    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)というナウでヤングなcoolなすごいIoTフレームワークを使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
    - 令和２年なのに未だに我が家の主力Raspberry Pi 2が毎日自動更新しております
      - [TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
    - この記事自身があわよくば賞をいただけるようなことがもしあるならば、いただいたプレゼントにてテンションがあがり、**自分の心**という一番御しがたい開発環境を改善することにつながるとおもいまして「[開発環境を豊かにする開発事例](https://qiita.com/official-events/89fd4ad3c24d7882117d)」に応募します
      - **山中の賊を破るは易く心中の賊を破るは難し**

    https://qiita.com/official-events/89fd4ad3c24d7882117d

    # 日本マイクロソフト賞④
    - 開発環境を豊かにする開発事例ーーそれは[Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)に積極的に投稿を行ったことです
    - 結果は、[マイクロソフト賞 ④：「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる (@torifukukaiou さん)](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)を受賞することができました
    - このとき賞品としていただいた、ボタン操作で机の高さを調整できる[FLEXISPOT スタンディングデスク 電動式 昇降デスク ＆ 天板](https://flexispot.jp/desk/height-adjustable-desks)は開発環境を改善してくれました
      - たまには立ってPCと向き合うことができています
      - 150cm x 70cmの天板にモノを全部ならべることができてすっきりしています
    - そうしてさらに、マイクロソフトさんのYouTubeチャンネル[クラウドデベロッパーちゃんねる](https://www.youtube.com/channel/UCMmRHq3E_9Hc9noZeo3zDCw)に出していただけました
    - :movie_camera: [Qiita Advent Calendar インタビュー特集第1弾 Elixir と Azure の愛を語る！](https://www.youtube.com/watch?v=R3o8vR1A9ao) :movie_camera:

    ![IMG_20210130_144449.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a088e754-3684-dc25-e72c-53a041469f15.jpeg)

    # [NervesJP](https://nerves-jp.connpass.com/)
    - ここで自動更新につかっている[Nerves](https://www.nerves-project.org/)のコミュニティ[NervesJP](https://nerves-jp.connpass.com/)のご紹介です
      - 月1回程度、ワイワイガヤガヤ オンラインで集まっています
    - 愉快なfolksたちがあなたの参加を待っています
    - れっつじょいな〜す
    - https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk
    - ぜひぜひSlackにご参加ください :rocket::rocket::rocket::rocket::rocket:



    ![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)
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
end
