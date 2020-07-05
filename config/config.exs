# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :hello_nerves,
  target: Mix.target(),
  nhk_api_key: System.get_env("HELLO_NERVES_NHK_API_KEY"),
  nhk_area: System.get_env("HELLO_NERVES_NHK_AREA"),
  nhk_favorite_acts: System.get_env("HELLO_NERVES_NHK_FAVORITE_ACTS"),
  nhk_favorite_titles: System.get_env("HELLO_NERVES_NHK_FAVORITE_TITLES"),
  twitter_query: System.get_env("HELLO_NERVES_TWITTER_QUERY"),
  twitter_last_created_at:
    System.get_env("HELLO_NERVES_TWITTER_LAST_CREATED_AT") |> String.to_integer(),
  twitter_search_interval:
    System.get_env("HELLO_NERVES_TWITTER_SEARCH_INTERVAL") |> String.to_integer(),
  slack_incoming_webhook_url: System.get_env("HELLO_NERVES_SLACK_INCOMING_WEBHOOK_URL"),
  slack_channel: System.get_env("HELLO_NERVES_SLACK_CHANNEL")

config :hello_nerves, HelloNerves.Scheduler,
  jobs: [
    # Every minute
    {"0 22 * * *", {HelloNerves, :update, []}},
    {"0 14 * * *", {HelloNerves, :update, []}},
    {"5 22 * * *", {HelloNerves, :tweet_autorace, []}},
    {"59 21 * * *", {HelloNerves, :sound_forecast, [400_030, 3]}},
    {"30 22 * * *", {HelloNerves, :sound_forecast, [400_030, 3]}},
    {"0 20 * * *", {Nhk, :run, []}},
    {"0 23 * * *", {Qiita, :run, []}},
    {"0 11 * * *", {Qiita, :run, []}}
  ]

config :docomo_text_to_speech,
  api_key: System.get_env("DOCOMO_TEXT_TO_SPEECH_API_KEY")

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
