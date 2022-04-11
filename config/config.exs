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

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

if Mix.target() == :host or Mix.target() == :"" do
  import_config "host.exs"
else
  import_config "target.exs"
end

config :hello_nerves,
  target: Mix.target(),
  env: Mix.env(),
  nhk_api_key: System.get_env("HELLO_NERVES_NHK_API_KEY"),
  nhk_area: System.get_env("HELLO_NERVES_NHK_AREA"),
  nhk_favorite_acts: System.get_env("HELLO_NERVES_NHK_FAVORITE_ACTS"),
  nhk_favorite_titles: System.get_env("HELLO_NERVES_NHK_FAVORITE_TITLES"),
  twitter_query: System.get_env("HELLO_NERVES_TWITTER_QUERY"),
  twitter_last_created_at:
    System.get_env("HELLO_NERVES_TWITTER_LAST_CREATED_AT", "0") |> String.to_integer(),
  twitter_search_interval:
    System.get_env("HELLO_NERVES_TWITTER_SEARCH_INTERVAL", "300000") |> String.to_integer(),
  slack_incoming_webhook_url: System.get_env("HELLO_NERVES_SLACK_INCOMING_WEBHOOK_URL"),
  slack_channel: System.get_env("HELLO_NERVES_SLACK_CHANNEL"),
  open_weather_api_key: System.get_env("HELLO_NERVES_OPEN_WEATHER_API_KEY"),
  azure_text_to_speech_subscription_key:
    System.get_env("HELLO_NERVES_AZURE_TEXT_TO_SPEECH_SUBSCRIPTION_KEY")

config :hello_nerves, HelloNerves.Scheduler,
  jobs: [
    # Every minute
    {"0 22 * * *", {HelloNerves, :update, []}},
    {"0 14 * * *", {HelloNerves, :update, []}},
    {"5 22 * * *", {HelloNerves, :tweet_autorace, []}},
    {"59 21 * * *",
     {HelloNerves, :sound_forecast,
      [%{"coord" => %{"lat" => 33.633331, "lon" => 130.683334}, "id" => 1_861_835}, 3]}},
    {"30 22 * * *",
     {HelloNerves, :sound_forecast,
      [%{"coord" => %{"lat" => 33.633331, "lon" => 130.683334}, "id" => 1_861_835}, 3]}},
    {"0 20 * * *", {Nhk, :run, []}},
    {"0 0 * * *", {Qiita, :run, [false]}},
    {"0 2 * * *", {Qiita, :run, [false]}},
    {"0 4 * * *", {Qiita, :run, [false]}},
    {"0 6 * * *", {Qiita, :run, [false]}},
    {"0 8 * * *", {Qiita, :run, [false]}},
    {"0 10 * * *", {Qiita, :run, [false]}},
    {"0 12 * * *", {Qiita, :run, [false]}},
    {"0 14 * * *", {Qiita, :run, [false]}},
    {"0 16 * * *", {Qiita, :run, [false]}},
    {"0 18 * * *", {Qiita, :run, [false]}},
    {"0 20 * * *", {Qiita, :run, [false]}},
    {"0 22 * * *", {Qiita, :run, [false]}},
    {"0 1 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 3 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 5 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 7 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 9 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 11 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 13 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 15 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 17 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 19 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 21 * * *", {Qiita.Events.Qiitadelika202203, :run, []}},
    {"0 23 * * *", {Qiita.Events.QiitaWishNewFaceTheBest202204, :run, []}},
    {"0 9 * * *", {Qiita.Yubaba, :run, []}},
    {"0 21 * * *", {Qiita.Yubaba, :run, []}},
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
    {"20 12 * * *", {Qiita.Events.AdventCalendar2022Tag, :run, []}},
    {"20 16 * * *", {Qiita.Events.AdventCalendar2022Tag, :run, []}},
    {"20 20 * * *", {Qiita.Events.AdventCalendar2022Tag, :run, []}},
    {"1 22 * * *", {HelloNerves.TrashDay, :run, []}}
  ]

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
