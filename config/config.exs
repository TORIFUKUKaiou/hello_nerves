# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and is restricted to
# this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :hello_nerves, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1597551838"

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

config :hello_nerves,
  target: Mix.target(),
  mix_tasks_upload_hotswap_enabled: Mix.env() == :dev,
  nhk_api_key: System.get_env("HELLO_NERVES_NHK_API_KEY"),
  nhk_area: System.get_env("HELLO_NERVES_NHK_AREA"),
  nhk_favorite_acts: System.get_env("HELLO_NERVES_NHK_FAVORITE_ACTS"),
  nhk_favorite_titles: System.get_env("HELLO_NERVES_NHK_FAVORITE_TITLES"),
  slack_incoming_webhook_url: System.get_env("HELLO_NERVES_SLACK_INCOMING_WEBHOOK_URL"),
  slack_channel: System.get_env("HELLO_NERVES_SLACK_CHANNEL"),
  open_weather_api_key: System.get_env("HELLO_NERVES_OPEN_WEATHER_API_KEY"),
  azure_text_to_speech_subscription_key:
    System.get_env("HELLO_NERVES_AZURE_TEXT_TO_SPEECH_SUBSCRIPTION_KEY")

config :hello_nerves, HelloNerves.Scheduler,
  jobs: [
    # Every minute
    {"0 0 * * *", {Qiita, :run, [false]}},
    {"0 12 * * *", {Qiita, :run, [false]}},
    {"0 16 * * *", {Qiita, :run, [false]}},
    {"0 18 * * *", {Qiita, :run, [false]}},
    {"0 20 * * *", {Qiita, :run, [false]}},
    {"0 22 * * *", {Qiita, :run, [false]}},
    {"0 1 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 2 * * *", {Qiita.Events.AdventCalendar2022Kansousyou, :run, []}},
    {"0 3 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 5 * * *", {Qiita.Events.Qiita6d31965c499a69377c0b, :run, []}},
    {"0 13 * * *", {Qiita.Events.Qiitaae80b010f51f7018891a, :run, []}},
    {"0 14 * * *", {Qiita.Events.AdventCalendar2022Kansousyou, :run, []}},
    {"0 21 * * *", {Qiita.Events.AdventCalendar2022Kansousyou, :run, []}},
    {"0 23 * * *", {Qiita.Events.QiitaEngineerFesta2022, :run, []}},
    {"0 9 * * *", {Qiita.Yubaba, :run, []}},
    {"30 0 * * *", {Qiita.CafeDung, :run, []}},
    {"45 0 * * *", {Qiita.MicrosoftIgnite, :run, []}},
    {"15 0 * * *", {Qiita.Azure.MicrosoftJava, :run, []}},
    {"10 0 * * *", {Qiita.Azure.MicrosoftAI, :run, []}},
    {"10 0 * * *", {Qiita.Azure.MicrosoftBuild, :run, []}},
    {"25 0 * * *", {Qiita.Azure.MicrosoftIoT, :run, []}},
    {"5 0 * * *", {Qiita.Azure.K8s, :run, []}},
    {"5 9 * * *", {Qiita.Azure.Certification, :run, []}},
    {"5 20 * * *", {Qiita.Azure.Certification, :run, []}},
    {"10 4 * * *", {Qiita.EngineerFesta, :run, []}},
    {"20 0 * * *", {Qiita.Tenth, :run, []}},
    {"20 8 * * *", {Qiita.Events.AdventCalendar2022Tag, :run, []}},
    {"20 4 * * *", {Qiita.Events.AdventCalendar2022Tag, :run, []}},
    {"20 12 * * *", {Qiita.Events.Qiita5fdc281997d5754d8ac9, :run, []}},
    {"20 16 * * *", {Qiita.Events.Qiita8e3542610897d988e66d, :run, []}},
    {"20 20 * * *", {Qiita.Events.Qiita668cbcb3b0f037d55e27, :run, []}},
    {"1 22 * * *", {HelloNerves.TrashDay, :run, []}}
  ]
