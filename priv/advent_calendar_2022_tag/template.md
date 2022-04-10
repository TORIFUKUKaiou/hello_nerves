https://qiita.com/kaizen_nagoya/items/0f48e2a8402f40630976

# この記事は

[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグが付いた記事を集めました。
2022/12/25を楽しみに！　せっせと記事を書き始めています。


[Qiita API v2](https://qiita.com/api/v2/docs)を利用させていただいています。

あつまった記事群（データ）にあれこれしてみます。

- LGTM数順に記事を並べます
- 投稿者ごとの記事数を集計します
- 投稿者ごとのLGTM数を集計します
- tagごとの記事数を集計します
- tagごとのLGTM数を集計します


---

# 総件数
<%= item_count %>件 :tada::tada::tada:

# LGTM数 :confetti_ball::military_medal::confetti_ball:
<%= table_a %>

ここでは、LGTM数が7以上の記事に絞っています。

LGTM数 7以上の意味は、「[Advent Calendar 2022 tag](https://qiita.com/kaizen_nagoya/items/0f48e2a8402f40630976)」の記事内の

> いいね(LGTM)が７以上の記事を一覧から抜き書きしてみます。

に従っています。

# 投稿者ごとの記事数とLGTM数
<%= table_b %>

# 投稿者ごとのLGTM数と記事数
<%= table_c %>

# タグごとの記事数とLGTM数
<%= table_d %>

# タグごとのLGTM数と記事数
<%= table_e %>

---

# Wrapping up :lgtm: :qiitan: :lgtm:

2022/12/25がくるのが楽しみです！
それまでにたくさんの良い記事と出会えることを期待しています。

---

最後に、この記事を自動更新しているプログラムについて補足しておきます。

- 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
  - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
  - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
  - Raspberry Pi 2で動いています。
- [Elixir](https://elixir-lang.org/)には、データを自在に取り扱える[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールがあります
- [Elixir](https://elixir-lang.org/)をはじめてみようという方は、[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールの習得からはじめるとよいとおもいます
- [WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127) :book: の特集２「Elixirによる高速なWeb開発！ 作って学ぶPhoenix」は、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しめる[Phoenix](https://www.phoenixframework.org/)の基礎がぎっしりと詰まっていて、**オススメ**です
- プログラムは、 https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/events/advent_calendar_2022.ex にあります

https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/events/advent_calendar_2022.ex

