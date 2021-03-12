defmodule Azure.TextToSpeech do
  @subscription_key Application.get_env(:hello_nerves, :azure_text_to_speech_subscription_key)

  def run!(text) do
    access_token()
    |> voice(text)
  end

  def access_token do
    headers = [
      "Ocp-Apim-Subscription-Key": @subscription_key,
      "Content-type": "application/x-www-form-urlencoded"
    ]

    "https://japaneast.api.cognitive.microsoft.com/sts/v1.0/issuetoken"
    |> HTTPoison.post!("", headers)
    |> Map.get(:body)
  end

  def voices_list(token) do
    "https://japaneast.tts.speech.microsoft.com/cognitiveservices/voices/list"
    |> HTTPoison.get!(authorization_header(token))
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def voice(token, text) do
    headers =
      authorization_header(token)
      |> Keyword.merge(
        "Content-Type": "application/ssml+xml",
        "X-Microsoft-OutputFormat": "riff-24khz-16bit-mono-pcm",
        "User-Agent": "awesome"
      )

    locale = "ja-JP"
    gender = "Female"

    %{"Name" => name} =
      voices_list(token)
      |> Enum.filter(fn %{"Locale" => l} -> l == locale end)
      |> Enum.filter(fn %{"Gender" => g} -> g == gender end)
      |> Enum.random()

    body = """
    <speak version='1.0' xml:lang='#{locale}'>
      <voice xml:lang='#{locale}' xml:gender='#{gender}' name='#{name}'>
        <prosody volume="100.0">
          #{text}
        </prosody>
      </voice>
    </speak>
    """

    "https://japaneast.tts.speech.microsoft.com/cognitiveservices/v1"
    |> HTTPoison.post!(body, headers)
    |> Map.get(:body)
  end

  defp authorization_header(token) do
    [Authorization: "Bearer #{token}"]
  end
end
