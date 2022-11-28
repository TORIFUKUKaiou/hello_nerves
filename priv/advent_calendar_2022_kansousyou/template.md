<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>

https://qiita.com/advent-calendar/2022

https://qiita.com/advent-calendar/2022/elixir

# はじめに

闘魂と[Elixir](https://elixir-lang.org/)が出会いました。
闘魂 meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

本日は、[Elixir](https://elixir-lang.org/)でこんなことができますよー　を紹介します。
題材は、一つのカレンダーに各人が何件投稿したのかを調べるプログラムを[Elixir](https://elixir-lang.org/)で作ることを楽しみます。
つまり、[完走賞](https://qiita.com/advent-calendar/2022/present-calendar)の応援記事です。

![スクリーンショット 2022-11-23 11.55.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/df5f4394-e423-36e7-c253-c462e00c3c85.png)

**この記事は定期的に実行結果を自動更新しています。**

# [Elixir](https://elixir-lang.org/)のプログラム

さっそくプログラムを示します。
闘魂Elixirを一通り学んだあとはより理解が進むでしょうし、なにかしらプログラミングの経験があればなんとなくご理解いただけるものとおもっております。

```elixir:sample.exs
Mix.install [{:req, "~> 0.3.0"}, {:floki, "~> 0.34.0"}]

with %{status: 200, body: html} <- Req.get!("https://qiita.com/advent-calendar/2022/elixir"),
    {:ok, parsed_doc} <- Floki.parse_document(html),
    [{_tag, _attrs, json} | _] <- Floki.find(parsed_doc, "[data-js-react-on-rails-store=AppStoreWithReactOnRails]"),
    {:ok, decoded} <- Jason.decode(json),
    [table_advent_calendars | _] <- get_in(decoded, ["adventCalendars", "tableAdventCalendars"]) do
  table_advent_calendars
  |> Map.fetch!("items")
  |> Enum.frequencies_by(&get_in(&1, ["user", "urlName"]))
  |> Enum.sort_by(fn {_user, cnt} -> cnt end, :desc)
else 
  _ -> :error
end
|> IO.inspect()
```

# 実行

Dockerで実行します。
`sample.exs`を作ったディレクトリで`docker run`してください。

```bash:CMD
docker pull hexpm/elixir:1.14.2-erlang-25.1.2-alpine-3.16.2

docker run --rm -v $PWD:/app hexpm/elixir:1.14.2-erlang-25.1.2-alpine-3.16.2 sh -c "mix local.hex --force && mix local.rebar --force && cd /app && elixir sample.exs"
```

2日目の「[闘魂Elixir ── 02. インストール](https://qiita.com/torifukukaiou/items/42bc08509fa97fa970ae)」を参考に、[Elixir](https://elixir-lang.org/)をインストールしてくださった方は、[IEx](https://hexdocs.pm/iex/IEx.html)を起動して動かしてみてください。

# 実行結果 (<%= now %>現在)

実行結果です。
(**ここは自動的に更新しています**)


```elixir
<%= result %>
```

記事の数が25を超えていると、[完走賞](https://qiita.com/advent-calendar/2022/present-calendar)の候補です。
現状、<%= count %>名が候補です。

# ワンポイントレッスン

`sample.exs`中、`"https://qiita.com/advent-calendar/2022/elixir"`をお好みのカレンダーのURLに変えると、ユーザー毎の記事数がわかります。
~~ただし、無理やりなところがあるので、すべてのカレンダーで動くとは限りません。なんとなく、カレンダーのシリーズが複数あるカレンダーでは動作するようにおもいます。無理やりなところというのは、特に`String.split("encryptedId")`の部分です。~~
↑↑↑@mnishiguchi さんのスペシャルサンクスにより改善しました！↑↑↑

[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)は、パイプ演算子と呼ばれます。

https://qiita.com/zacky1972/items/2dc7c4930f6ab8a4688a


# 今日の<font color="#d00080">闘魂</font>

今日は、『南洲翁遺訓』から言葉を引きます。

---

<ruby>
人を相手にせず、天を相手にせよ。天を相手にして、己れを尽くし人を咎めず、我が誠の足らざるを尋ぬ可し。
<rt>ひとをあいてにせず、てんをあいてにせよ。てんをあいてにして、おのれをつくしひとをとがめず、わがまことのたらざるをたずぬべし</rt>
</ruby>

---

解説は、[こちら](http://www.hyugagakuin.ac.jp/about/words/e/2021/03/09/002142.html)をご参照ください。
猪木さん流に言うと、「闘魂」であり「夢というのは、純粋性がなければダメなんだ」ということです。


> 不純な夢は、人に見透かされる。けれども、純粋な夢は人に応援される。それだけで、夢の実現度は大きく変わってくるはずだ。(中略)彼が裏切ろうと真犯人が別にいようと、どうでもいい。わたしは、すべての過去を根に持たないからだ。

天つまりお天道様に恥ずかしくない、別の言い方をすると誰に対しても恥じることのない夢というものは、純なものだということです。純であるがゆえに賛同する人もでてくるのです。

稲盛和夫師の「[動機善なりや、私心なかりしか](https://www.kyocera.co.jp/inamori/philosophy/words47.html)」にも通じます。

ちなみに、稲盛和夫師は鹿児島県出身で西郷南洲翁を敬愛していることはよく知られていることだとおもいます。猪木さんも実は、鹿児島に縁があることはあまり知られてはいないのではいでしょうか。猪木さんのお生まれは神奈川県鶴見であることは知られています。猪木さんの父は鹿児島県出水の出身とのことです。[アントニオ猪木自伝](https://www.shinchosha.co.jp/book/129721/):book:の中で述べられています。
また、稲盛経営１２ヶ条の第８条には「[燃える闘魂 ―経営にはいかなる格闘技にもまさる激しい闘争心が必要― ](https://www.kyocera.co.jp/inamori/management/twelve/twelve08.html)」が掲げられています。「燃える闘魂」といえば、今度は猪木さんのことのほうを思い浮かべる方が多いのではないでしょうか。
「鹿児島県（つまりは郷中教育、西郷南洲翁）」「燃える闘魂」になにやら目に見えないたて糸、もしくはぶっとい柱が通っていることを私は感じます。

:book:『[アントニオ猪木 最後の闘魂](https://www.amazon.co.jp/dp/4833481057)』:book:から引きました。
みなさまもぜひこの本をお手にとられて、猪木さんが残されたメッセージを通じて、直接猪木さんから「元氣」をもらってください。


![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/be8933f5-e3e2-d5f4-1561-f65f75abdf38.png)




# さいごに

[Elixir](https://elixir-lang.org/)でこんなことができますよー　を紹介しました。
題材は、一つのカレンダーに各人が何件投稿したのかを調べるプログラムを[Elixir](https://elixir-lang.org/)で作ることを楽しみました。
つまり、[完走賞](https://qiita.com/advent-calendar/2022/present-calendar)の応援記事でもあるわけです。

闘魂の意味は、 **「己に打ち克ち、闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。

<font color="red">$\huge{１、２、３ ぁっダー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4
