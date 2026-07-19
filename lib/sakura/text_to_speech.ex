defmodule Sakura.TextToSpeech do
  @token Application.compile_env(:hello_nerves, :sakura_ai_engine_token)
  @model Application.compile_env(:hello_nerves, :sakura_ai_engine_model, "zundamon")
  @voice Application.compile_env(:hello_nerves, :sakura_ai_engine_voice)
  @base_url "https://api.ai.sakura.ad.jp/v1"

  def run!(text) do
    body =
      %{"model" => @model, "input" => text}
      |> maybe_put_voice()

    "#{@base_url}/audio/speech"
    |> Req.post!(
      json: body,
      headers: [authorization: "Bearer #{@token}"],
      pool_timeout: 50000,
      receive_timeout: 50000,
      connect_options: [timeout: 50_000]
    )
    |> Map.get(:body)
  end

  defp maybe_put_voice(map) do
    if @voice, do: Map.put(map, "voice", @voice), else: map
  end
end
