defmodule Qiita do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [%{"name" => "Elixir"}, %{"name" => "Qiita夏祭り2020_パソナテック"}],
      "【毎日自動更新】QiitaのElixir LGTMランキング！"
    )

    ExTwitter.update("""
    Automatic Updates
    https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd

    I use Nerves. I like it!
    #myelixirstatus #NervesJP
    #{Timex.now() |> Timex.to_datetime() |> DateTime.to_string()}
    """)
  end

  defp markdown do
    items = Qiita.Api.items()

    """
    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # 新着 :hatching_chick::baby_chick::hatched_chick:
    #{filter(items, Timex.now() |> Timex.shift(days: -2), "created_at", 1000)}

    # 直近1ヶ月
    #{filter(items, Timex.now() |> Timex.shift(days: -30))}

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{filter(items, Timex.from_unix(0))}

    # [Elixir](https://elixir-lang.org/)のみを使って、今QiitaのElixir LGTMランキングを作ってみました
    - 実行環境は、もちろん[Nerves](https://www.nerves-project.org/) :robot:
    - [ソースコード](https://github.com/TORIFUKUKaiou/hello_nerves/pull/34) ※その後いろいろ変えています :fire::fire::fire:

    ## Motivation
    - 私は、いつも検索窓に`elixir`と打ち込んで新着記事を読むのを楽しみにしています
    - [API](https://qiita.com/api/v2/docs)の存在を知り、当初は検索結果を[Slack](https://slack.com/)へ通知することを考えていました
    - 毎日、自動で更新されている記事が目にとまりまして、[Qiita](https://qiita.com/)で得た情報は、[Qiita](https://qiita.com/)にアウトプットしよう！ ということを思いつきました
    - ちょうど、[〇〇（言語）のみを使って、今△△（アプリ）を作るとしたら](https://qiita.com/official-events/5d181aadf5db26b73d33) という夏祭りが気になっておりまして、私の中では〇〇は[Elixir](https://elixir-lang.org/)一択でした
      - I was born to love [Elixir](https://elixir-lang.org/).
    - △△はなかなか思い浮かばなかったのですが、「検索窓に`elixir`と打ち込んで新着記事を探す」部分の自動化とでもいいますか、とにかく自分が欲しいものを楽しみながら作りました
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
    - そうやってどんどん源流の方に思いを巡らせていきますと、コンピューターサイエンスとか、私が知らない無数の発明、そして多くの人々に支えられていてるのだと気づきます
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
    |> build_table(key)
  end

  defp build_table(items, title_of_date) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|title|#{title_of_date}|LGTM|\n|---|---|---|---|\n", fn {item, index},
                                                                               acc_string ->
      %{
        "title" => title,
        "likes_count" => likes_count,
        "updated_at" => updated_at,
        "url" => url,
        "user_id" => user_id
      } = item

      acc_string <>
        "|#{index}|[#{title}](#{url})<br>@#{user_id}|#{
          updated_at |> Timex.to_date() |> Date.to_string()
        }|#{likes_count}|\n"
    end)
  end
end
