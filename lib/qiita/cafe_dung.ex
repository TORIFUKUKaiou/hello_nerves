defmodule Qiita.CafeDung do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "ネタ"},
        %{"name" => "カフェでプログラミングしてる風"}
      ],
      "【毎日自動更新】カフェでプログラミングしてる風（でも何もやってない） LGTMランキング！",
      "b70dc5476762225cd4a2"
    )
  end

  defp markdown do
    items =
      Qiita.Api.items(
        "title:カフェでプログラミングしてる風 OR tag:カフェでプログラミングしてる風 OR title:スタバでつよつよエンジニアを演じられるプログラム"
      )

    sorted_items =
      Enum.sort_by(items, fn %{"likes_count" => likes_count} -> likes_count end, :desc)

    """
    # この記事は
    - @3S_Laboo さんの[カフェでプログラミングしてる風（でも何もやってない）Java（クソ）コード](https://qiita.com/3S_Laboo/items/660883a0184dabaea65b)よりはじまった「カフェでプログラミングしてる風」関連記事のリンク集です
      - [`"title:カフェでプログラミングしてる風 OR tag:カフェでプログラミングしてる風 OR title:スタバでつよつよエンジニアを演じられるプログラム"`](https://qiita.com/search?q=title%3A%E3%82%AB%E3%83%95%E3%82%A7%E3%81%A7%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E3%81%97%E3%81%A6%E3%82%8B%E9%A2%A8+OR+tag%3A%E3%82%AB%E3%83%95%E3%82%A7%E3%81%A7%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E3%81%97%E3%81%A6%E3%82%8B%E9%A2%A8+OR+title%3A%E3%82%B9%E3%82%BF%E3%83%90%E3%81%A7%E3%81%A4%E3%82%88%E3%81%A4%E3%82%88%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E3%82%92%E6%BC%94%E3%81%98%E3%82%89%E3%82%8C%E3%82%8B%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0) で検索しています
      - LGTM数順に並べています

    https://qiita.com/3S_Laboo/items/660883a0184dabaea65b

    # 総件数
    #{Enum.count(items)}件 :tada::tada::tada:

    # 全期間 :confetti_ball::military_medal::confetti_ball:
    #{build_table(sorted_items)}

    # Wrapping up :lgtm: :qiitan: :lgtm:
    - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
      - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
      - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)

    # タグ別まとめ(TBD)

    ![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4b94399e-f21e-516e-8cdc-e3837aaa005b.gif)
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
