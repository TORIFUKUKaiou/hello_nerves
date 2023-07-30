# HelloNerves

- Weather.Forecast.run means getting "http://api.openweathermap.org/data/2.5/weather?id=#{city}&lang=ja&units=metric&appid=#{appid}".

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`.
    I use `MIX_TARGET=rpi2`
  * `export NERVES_NETWORK_SSID=ssid`
  * `export NERVES_NETWORK_PSK=secret`
  * `export TWITTER_CONSUMER_KEY=xxx`
  * `export TWITTER_CONSUMER_SECRET=yyy`
  * `export TWITTER_ACCESS_TOKEN=zzz`
  * `export TWITTER_ACCESS_TOKEN_SECRET=aaa`
  * `export TEXT_TO_SPEECH_API_KEY=ttt`
  * `export HELLO_NERVES_NHK_API_KEY=secret`
  * `export HELLO_NERVES_NHK_AREA=401`
  * `export HELLO_NERVES_NHK_FAVORITE_ACTS="加藤一二三,ベニシア・スタンリー・スミス,半澤鶴子"`
  * `export HELLO_NERVES_NHK_FAVORITE_TITLES"ＬＩＦＥ！,将棋"`
  * `export HELLO_NERVES_TWITTER_QUERY="NervesJP OR @NervesConf OR @NervesProject OR (Elixir AND Nerves) OR (Elixir AND IoT) -RT"`
  * `export HELLO_NERVES_TWITTER_SEARCH_INTERVAL="3600000"` # In 1 hour
  * `export HELLO_NERVES_TWITTER_LAST_CREATED_AT="1589804414"`
  * `export HELLO_NERVES_SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/secret/secret/secret"`
  * `export HELLO_NERVES_SLACK_CHANNEL="notification-awesome"`
  * `export HELLO_NERVES_OPEN_WEATHER_API_KEY="secret"`
  * Install dependencies with `mix deps.get`
  * Download `http://bulk.openweathermap.org/sample/city.list.json.gz` |> Ungz |> Put `rootfs_overlay/usr/local/share/city.list.json`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
