# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

This is `HelloNerves`, a [Nerves](https://hexdocs.pm/nerves/) (Elixir IoT) application that runs on a Raspberry Pi 2. It combines hardware control (LED blinking, GPIO) with scheduled automation tasks: updating Qiita articles, fetching NHK TV schedules, weather forecasts with text-to-speech, and auto-race tweets.

## Build and Development Commands

- **Install dependencies:** `mix deps.get`
- **Run tests:** `mix test`
- **Format code:** `mix format`
- **Run on host:** `iex -S mix`
- **Build firmware for target:** `MIX_TARGET=rpi2 mix firmware`
- **Burn firmware to SD card:** `MIX_TARGET=rpi2 mix burn`
- **Run a single test:** `mix test test/hello_nerves_test.exs`

The project uses [`mise`](https://mise.jdx.dev/) with `.tool-versions`: `elixir 1.19.1-otp-28`, `erlang 28.1.1`.

## Architecture

### Target vs. Host

`Mix.target()` distinguishes host development from target hardware.

- **Host (`:host`):** `HelloNerves.Application` supervises only `AwesomeNerves.Scheduler` (`lib/awesome_nerves/scheduler.ex`). Useful for running scheduled Qiita updates locally without hardware.
- **Target (e.g., `:rpi2`):** The supervisor also starts hardware-related children: `AwesomeNerves.Blinker`, `Observer`, `SetInterrupter`, and `Led.Lighter`.

Configuration files in `config/` reflect this split:
- `config.exs`: Shared config, selects `host.exs` or `target.exs`.
- `host.exs`: In-memory `Nerves.Runtime.KVBackend` for local dev.
- `target.exs`: `RingLogger`, `shoehorn`, `vintage_net` WiFi, `nerves_ssh` with authorized keys from `~/.ssh/*.pub`, and `mdns_lite` advertising `nerves-rpi2.local`.

### Scheduling (Quantum)

`AwesomeNerves.Scheduler` (a `Quantum` scheduler) is defined in `config/config.exs` with many cron jobs. Jobs include:
- Qiita article updates (`Qiita.run/1`, `Qiita.Haw.run/0`, event modules)
- Weather sound forecasts (`AwesomeNerves.sound_forecast/2`)
- NHK favorites (`Nhk.run/0`) via `AwesomeNerves.TrashDay`

### Qiita Automation

The `Qiita` namespace (`lib/qiita.ex` and submodules) automates updating Qiita posts via the Qiita API (`lib/qiita/api.ex`). Most event-specific modules under `lib/qiita/events/` follow a pattern of:
- A main module that defines `run/0`
- A `MarkdownGenerator` submodule that builds the article body
- A `Repo` module that provides items or data

### NHK TV Schedule

`lib/nhk.ex` queries the NHK API for TV programs across multiple services (`g1`, `e1`, `e4`, `s1`, `s3`, `r1`, `r2`, `r3`) using `Flow` for concurrent fetching. It filters by favorite acts and titles configured via environment variables.

### Hardware / Peripherals

On real hardware:
- `AwesomeNerves.Led.Lighter` controls LEDs via `circuits_gpio`
- `AwesomeNerves.Blinker` handles blinking patterns
- `AwesomeNerves.Observer` and `SetInterrupter` are GPIO-related observers/interrupters
- `AwesomeNerves.sound_forecast/2` fetches weather (`Weather.Forecast`) and uses Azure TTS (`Azure.TextToSpeech`) to play audio via `aplay` on the device or `afplay` on macOS host

## Environment Variables

Many external services are configured through environment variables (see `README.md` and `config/config.exs`):
- `MIX_TARGET` — Nerves target (`rpi2`, etc.)
- `NERVES_NETWORK_SSID`, `NERVES_NETWORK_PSK` — WiFi credentials
- `HELLO_NERVES_QIITA_READ_WRITE_TOKEN`, `HELLO_NERVES_QIITA_ITEM_ID`
- `HELLO_NERVES_NHK_API_KEY`, `HELLO_NERVES_NHK_AREA`, `HELLO_NERVES_NHK_FAVORITE_ACTS`, `HELLO_NERVES_NHK_FAVORITE_TITLES`
- `HELLO_NERVES_OPEN_WEATHER_API_KEY`
- `HELLO_NERVES_AZURE_TEXT_TO_SPEECH_SUBSCRIPTION_KEY`
- `HELLO_NERVES_SLACK_INCOMING_WEBHOOK_URL`, `HELLO_NERVES_SLACK_CHANNEL`
- `HELLO_NERVES_COOKIE` — For remote hotswap via `mix_tasks_upload_hotswap`

## Important Files

- `mix.exs` — Standard Mix project for Nerves with `@all_targets` and `MIX_TARGET` logic
- `lib/hello_nerves/application.ex` — OTP supervisor that branches on `Mix.target()`
- `lib/awesome_nerves/scheduler.ex` — Quantum cron scheduler
- `lib/qiita/api.ex` — HTTPoison-based Qiita API client
- `lib/nhk/api.ex` — NHK program listing API client
- `rootfs_overlay/` — Custom files included in the firmware image (e.g., `etc/iex.exs`)

## Code Style

- Use `mix format` to format code. The `.formatter.exs` includes `rootfs_overlay/etc/iex.exs`.
- The project relies on compile-time env via `Application.compile_env/3` in some modules (e.g., `Nhk`).
- When adding new scheduled jobs, register them in both `config/config.exs` and the appropriate module.
