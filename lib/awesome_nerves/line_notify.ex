defmodule AwesomeNerves.LineNotify do
  @url "https://notify-api.line.me/api/notify"
  @token System.get_env("HELLO_NERVES_LINE_NOTIFY_TOKEN")
  @headers [Authorization: "Bearer #{@token}"]

  def post(msg) do
    Req.post(@url, form: [message: msg], headers: @headers)
  end
end
