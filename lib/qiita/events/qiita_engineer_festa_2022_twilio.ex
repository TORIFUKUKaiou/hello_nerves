defmodule Qiita.Events.QiitaEngineerFesta2022Twilio do
  alias Qiita.Events.QiitaEngineerFesta2022Twilio.MarkdownGenerator
  alias Qiita.Events.Repo

  def run do
    query = "tag:QiitaEngineerFesta_Twilio tag:Twilio"
    start_time = DateTime.new(~D[2022-05-31], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    end_time = DateTime.new(~D[2022-07-18], ~T[15:00:00.000], "Etc/UTC") |> elem(1)
    tags = ["Elixir", "40代駆け出しエンジニア", "AdventCalendar2022", "QiitaEngineerFesta_Twilio", "Twilio"]
    title = "【毎日自動更新】Twilioを使うためのコツ、Tipsやおもしろ実装など、Twilioのことなら何でも共有しよう！ LGTMランキング！"
    id = "7f9141f7b943ccb2edff"

    Repo.fetch_items(query, start_time, end_time)
    |> MarkdownGenerator.generate()
    |> Repo.post_markdown(tags, title, id)
  end
end
