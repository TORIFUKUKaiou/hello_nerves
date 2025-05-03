defmodule Azure.TextToSpeech do
  @subscription_key Application.compile_env(
                      :hello_nerves,
                      :azure_text_to_speech_subscription_key
                    )
  @locale "ja-JP"
  @gender "Female"
  @voice_type "Neural"

  def run!(text) do
    access_token()
    |> voice(text)
  end

  def access_token do
    headers = [
      "Ocp-Apim-Subscription-Key": @subscription_key,
      "Content-type": "application/x-www-form-urlencoded"
    ]

    "https://eastus.api.cognitive.microsoft.com/sts/v1.0/issuetoken"
    |> HTTPoison.post!("", headers)
    |> Map.get(:body)
  end

  def voices_list(token) do
    "https://eastus.tts.speech.microsoft.com/cognitiveservices/voices/list"
    |> HTTPoison.get!(authorization_header(token))
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def voice(token, text) do
    %{"Name" => name} = select_voice(token)

    headers =
      authorization_header(token)
      |> Keyword.merge(
        "Content-Type": "application/ssml+xml",
        "X-Microsoft-OutputFormat": "riff-24khz-16bit-mono-pcm",
        "User-Agent": "awesome"
      )

    "https://eastus.tts.speech.microsoft.com/cognitiveservices/v1"
    |> HTTPoison.post!(ssml(text, name), headers)
    |> Map.get(:body)
  end

  defp authorization_header(token) do
    [Authorization: "Bearer #{token}"]
  end

  defp select_voice(token) do
    voices_list(token)
    |> Enum.filter(fn %{"Locale" => l} -> l == @locale end)
    |> Enum.filter(fn %{"Gender" => g} -> g == @gender end)
    |> Enum.filter(fn %{"VoiceType" => vt} -> vt == @voice_type end)
    |> Enum.random()
  end

  defp ssml(text, name) do
    """
    <speak version='1.0' xml:lang='#{@locale}'>
      <voice xml:lang='#{@locale}' xml:gender='#{@gender}' name='#{name}'>
        <prosody volume="100.0">
          #{text}
        </prosody>
      </voice>
    </speak>
    """
  end
end
