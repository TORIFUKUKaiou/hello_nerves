# はじめに

私達、[ハウインターナショナル](https://www.haw.co.jp/)は、Qiita Organizationを利用させていただいております。

https://qiita.com/organizations/haw

自分たちの組織が書いた記事の一覧が欲しくなりました。
LGTM数順と新着順、投稿数順、使用したタグ数順に並べてみたくなりました。

[Qiita API v2](https://qiita.com/api/v2/docs)には、Organizationを指定して記事を取得するAPIは無いように見えました。
（本当はあったらごめんなさい :pray: :pray_tone1: :pray_tone2: :pray_tone3: :pray_tone4: :pray_tone5:）

無いなら**作ればいいじゃない！の精神**で作ってみました。

もちろん、私は[Elixir](https://elixir-lang.org/)で作ってみます。
そして出来上がった一覧は、Qiitaの記事として投稿し、自動更新によりアップデートをし続けることにしました。歩みを止めないことにしました。
その記事がこれです。

ぜひ私達、[ハウインターナショナル](https://www.haw.co.jp/)が投稿した記事をお楽しみください。

---

# 総件数

<%= item_count %>件 :tada::tada::tada:

# LGTM数順 :confetti_ball::military_medal::confetti_ball:

<%= table_a %>

# 新着順

<%= table_b %>

# 投稿数順

<%= table_c %>

# 使用したタグ数順

<%= table_d %>

---

# さいごに

この記事は、[ハウインターナショナル](https://www.haw.co.jp/)が投稿した記事の一覧です。
自動更新をしております。



---

最後に、この記事を自動更新しているプログラムについて補足しておきます。

- 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
  - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
  - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
  - 私の家に設置しているRaspberry Pi 2で動かしています
- [Elixir](https://elixir-lang.org/)には、データを自在に取り扱える[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールがあります
- [Elixir](https://elixir-lang.org/)をはじめてみようという方は、[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールの習得からはじめるとよいとおもいます
- プログラムは、 https://github.com/TORIFUKUKaiou/hello_nerves にあります
- プログラムのポイントは、「[闘魂Elixir ── 所属するQiita Organizationに投稿された記事をQiita APIを利用して取得することを楽しむ](https://qiita.com/torifukukaiou/items/9ea1d1652d08d330a2ce)」で解説しています

https://qiita.com/torifukukaiou/items/9ea1d1652d08d330a2ce

