# Nerves Emerge Demo

**TODO: Add description**

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/supported-targets.html

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix burn`

## WiFi Via Env

For target builds, WiFi credentials can be injected from environment variables
when you build the firmware:

```bash
export MIX_TARGET=rpi5
export NERVES_WIFI_SSID="your-ssid"
export NERVES_WIFI_PSK="your-passphrase"
export NERVES_REGULATORY_DOMAIN="US"
mix firmware
```

Notes:

  * `NERVES_WIFI_SSID` and `NERVES_WIFI_PSK` are read from `config/target.exs`
    while building firmware.
  * `WIFI_SSID` / `WIFI_PSK` and `WIFI_COUNTRY_CODE` / `WIFI_REGULATORY_DOMAIN`
    are also accepted as fallback names.
  * If `NERVES_WIFI_SSID` is set without a PSK, the network is treated as open.
  * The selected WiFi settings are baked into the built firmware image.

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Elixir Slack #nerves channel: https://elixir-slack.community/
  * Elixir Discord #nerves channel: https://discord.gg/elixir
  * Source: https://github.com/nerves-project/nerves
