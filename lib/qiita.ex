defmodule Qiita do
  def run(post \\ false) do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "Qiita夏祭り2020_パソナテック"},
        %{"name" => "Qiita夏祭り2020_Qiita"}
      ],
      "【毎日自動更新】QiitaのElixir LGTMランキング！"
    )

    if post do
      # do nothing
    end
  end

  defp markdown do
    items = Qiita.Api.items(["Elixir", "Nerves", "Phoenix"])

    """
    #{maybe_write_advent_calendar()}

    #{adventcalendar_table(items)}

    # 総件数 #{if AwesomeNerves.is_xmas?(),
      do: ":christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:",
      else: ""}
    #{Enum.count(items)}件 :tada::tada::tada:

    # 新着 :hatching_chick::baby_chick::hatched_chick:
    #{filter(items, Timex.now() |> Timex.shift(days: -3), "created_at", 1000) |> build_table("created_at")}

    # 直近1ヶ月
    #{filter(items, Timex.now() |> Timex.shift(days: -30)) |> build_table("updated_at")}

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{filter(items, Timex.from_unix(0)) |> build_table("updated_at")}

    # [Elixir](https://elixir-lang.org/)のみを使って、今QiitaのElixir LGTMランキングを作ってみました
    - 実行環境は、もちろん[Nerves](https://www.nerves-project.org/) :robot:
      - [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
      - Co-Author of [Nerves](https://www.nerves-project.org/) Projectの[Justin Schneck](https://twitter.com/mobileoverlord)さんからいいねをいただいています
    - [ソースコード](https://github.com/TORIFUKUKaiou/hello_nerves/pull/34) ※その後いろいろ変えています :fire::fire::fire:

    ## Motivation
    - 私は、いつも検索窓に`elixir`と打ち込んで新着記事を読むのを楽しみにしています
    - [API](https://qiita.com/api/v2/docs)の存在を知り、当初は検索結果を[Slack](https://slack.com/)へ通知することを考えていました
    - 毎日、自動で更新されている記事が目にとまりまして、[Qiita](https://qiita.com/)で得た情報は、[Qiita](https://qiita.com/)にアウトプットしよう！ ということを思いつきました
    - ちょうど、[〇〇（言語）のみを使って、今△△（アプリ）を作るとしたら](https://qiita.com/official-events/5d181aadf5db26b73d33) という夏祭りが気になっておりまして、私の中では〇〇は[Elixir](https://elixir-lang.org/)一択でした
      - I was born to love [Elixir](https://elixir-lang.org/).
    - △△はなかなか思い浮かばなかったのですが、「検索窓に`elixir`と打ち込んで新着記事を探す」部分の自動化とでもいいますか、とにかく自分が欲しいものを楽しみながら作りました
    - そうしてその後、これはもしかすると「APIを作った連携サービスやChrome拡張など、Qiitaに関わるものであれば形式は問いません」という概要の [みんなでQiitaを便利にしよう！](https://qiita.com/official-events/0e872f8893283d4fd212) の方にも該当するのではないかとおもいました
    - 自動化とかなんとか言っていますが、その後よくよくみると、[ココ](https://qiita.com/tags/elixir)をブックマークしておけば事足りますねという話を長々としているだけという気もしてきた今日このごろです
    - もう一度繰り返しますが、とにかく私は[Elixir](https://elixir-lang.org/)を書くことを楽しみました
    - **Enjoy!**

    ## 大河の一滴
    - 果たして私は、[Elixir](https://elixir-lang.org/)のみを使ったと言えるのだろうか、ふとそんなことをおもいました
    - たしかに今回、私が書いたのは[Elixir](https://elixir-lang.org/)のみです
    - ただそれは表面的なことにしかすぎないと感じています
    - [Elixir](https://elixir-lang.org/)は[Ruby](https://www.ruby-lang.org/)の影響を強く受けていると聞きますし、私は一行たりとも書いたことはありませんが知らず知らずのうちに[Erlang](https://www.erlang.org/)のお世話になっています
    - 実行環境には[Nerves](https://www.nerves-project.org/)をあげました
    - 私は[Nerves](https://www.nerves-project.org/)アプリケーションを動かす際にOSの存在をこれっぽっちも意識したことはありませんがLinuxが動いているはずです
    - Linuxはよく知りませんが、Cだか、C++だかでできているとおもいます
    - [Nerves](https://www.nerves-project.org/)アプリケーションのファームウェアをビルドできたとして、私にとって虎の子のRaspberry Pi 2というハードウェアがないと動かせないでしょう
    - そもそも我が家に電気が届いていなければRaspberry Pi 2に電源を投入することすらできません
    - そうやってどんどん源流の方に思いを巡らせていきますと、コンピューターサイエンスとか、私が知らない無数の発明、そして多くの人々とのつながりを感じます
    - ありがとうございます！
    - [永遠の時間に向かって動いていくリズムの一部](https://www.amazon.co.jp/dp/4877287043) であることを感じています
    - そして[Elixir](https://elixir-lang.org/)以外のものを使っているという私の告白は、たとえそれが[「〇〇（言語）のみを使って、今△△（アプリ）を作るとしたら」](https://qiita.com/official-events/5d181aadf5db26b73d33) という企画の趣旨にこの記事が沿っていないということを自ら宣言していることになろうとも、とにかく私は楽しみました
    - **Thanks!**
    """
  end

  defp filter(items, from, key \\ "updated_at", amount \\ 20) do
    items
    |> Enum.filter(fn %{^key => value} ->
      DateTime.compare(value, from) == :gt
    end)
    |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
    |> Enum.take(amount)
  end

  defp build_table(items, title_of_date) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|title|#{title_of_date}|LGTM|\n|---|---|---|---:|\n", fn {item, index},
                                                                                acc_string ->
      %{
        "title" => title,
        "likes_count" => likes_count,
        "updated_at" => updated_at,
        "url" => url,
        "user_id" => user_id
      } = item

      acc_string <>
        "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{Number.Delimit.number_to_delimited(likes_count, precision: 0)}|\n"
    end)
  end

  defp maybe_write_advent_calendar do
    if AwesomeNerves.is_xmas?() do
      """
      # メリークリスマス！ :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5:
      - [クリスマスエディション](https://github.com/TORIFUKUKaiou/hello_nerves/pull/54)
      - 以前から公開している記事ですがこの時期だからこそ見ていただきたく、アドベントカレンダーに登録しました
      - 12月限定の飾りをつけています！

      # アドベントカレンダー :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5:
      - ぜひご参加ください！
      - [Elixir Advent Calendar #{Timex.now().year}](https://qiita.com/advent-calendar/#{Timex.now().year}/elixir)
      - [#NervesJP Advent Calendar #{Timex.now().year}](https://qiita.com/advent-calendar/#{Timex.now().year}/nervesjp)
      """
    end
  end

  defp adventcalendar_table(items) do
    if AwesomeNerves.is_xmas?() do
      year = Timex.now().year

      advent_calendar_urls =
        [
          "https://qiita.com/advent-calendar/#{year}/elixir",
          "https://qiita.com/advent-calendar/#{year}/nervesjp"
        ]
        |> Enum.reduce([], fn calendar_url, acc ->
          acc ++ get_advent_calendar_urls(calendar_url)
        end)

      items
      |> Enum.filter(fn item -> item["url"] in advent_calendar_urls end)
      |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
      |> build_table("updated_at")
    end
  end

  defp get_advent_calendar_urls(calendar_url) do
    with %{status: 200, body: html} <-
           Req.get!(calendar_url, pool_timeout: 50000, receive_timeout: 50000),
         {:ok, parsed_doc} <- Floki.parse_document(html),
         [{_tag, _attrs, json} | _] <-
           Floki.find(parsed_doc, "[data-js-react-on-rails-store=AppStoreWithReactOnRails]"),
         {:ok, decoded} <- Jason.decode(json),
         [table_advent_calendars | _] <-
           get_in(decoded, ["adventCalendars", "tableAdventCalendars"]) do
      table_advent_calendars
      |> Map.fetch!("items")
      |> Enum.map(&get_in(&1, ["article", "linkUrl"]))
      |> Enum.filter(& &1)
      |> Enum.reject(&String.contains?(&1, "private"))
    else
      _ -> []
    end
  end
end
