defmodule Torifuku.TextToSpeech do
  # Please refer to https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01 .
  def text_to_speech(
        text,
        speaker_id \\ 1,
        style_id \\ 1,
        speech_rate \\ 1.0,
        power_rate \\ 1.0,
        voice_type \\ 1.0,
        audio_file_format \\ 2
      ) do
    url =
      "https://api.apigw.smt.docomo.ne.jp/crayon/v1/textToSpeech?APIKEY=#{
        Application.get_env(:hello_nerves, :text_to_speech_api_key)
      }"

    headers = [{"Content-Type", "application/json"}]

    json_data =
      %{
        Command: "AP_Synth",
        SpeakerID: speaker_id,
        StyleID: style_id,
        TextData: text,
        SpeechRate: speech_rate,
        PowerRate: power_rate,
        VoiceType: voice_type,
        AudioFileFormat: audio_file_format
      }
      |> Poison.encode!()

    HTTPoison.post!(url, json_data, headers) |> Map.get(:body)
  end
end
