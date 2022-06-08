defmodule Qiita.Events.QiitaEngineerFesta2022 do
  def run do
    [
      Qiita.Events.QiitaEngineerFesta2022Algorithm,
      Qiita.Events.QiitaEngineerFesta2022DL,
      Qiita.Events.QiitaEngineerFesta2022AzureMachineLearning,
      Qiita.Events.QiitaEngineerFesta2022ClarisConnect,
      Qiita.Events.QiitaEngineerFesta2022GitHubActions,
      Qiita.Events.QiitaEngineerFesta2022Snyk,
      Qiita.Events.QiitaEngineerFesta2022Books,
      Qiita.Events.QiitaEngineerFesta2022Twilio,
      Qiita.Events.QiitaEngineerFesta2022Incident,
      Qiita.Events.QiitaEngineerFesta2022RemoteTestKit,
      Qiita.Events.QiitaEngineerFesta2022Zoom,
      Qiita.Events.QiitaEngineerFesta2022RemoteIt,
      Qiita.Events.QiitaEngineerFesta2022ClarisFileMaker,
      Qiita.Events.QiitaEngineerFesta2022React18,
      Qiita.Events.QiitaEngineerFesta2022Sekkei
    ]
    |> Enum.each(fn mod ->
      Process.sleep(500)
      mod.run() |> IO.inspect()
    end)
  end
end
