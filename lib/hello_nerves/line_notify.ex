defmodule HelloNerves.LineNotify do
  @url "https://notify-api.line.me/api/notify"
  @token System.get_env("HELLO_NERVES_LINE_NOTIFY_TOKEN")
  @headers [Authorization: "Bearer #{@token}"]

  def post(msg) do
    HTTPoison.post(@url, {:form, [message: msg]}, @headers)
  end
end
