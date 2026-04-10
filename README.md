# Nerves Emerge Demo

A small demo application built with `Emerge` and `Solve` for Nerves. It renders
a simple animated UI over DRM and wires button presses into a counter
controller.

## Requirements

- Elixir `~> 1.19`
- One of the supported Nerves targets: `rpi4` or `rpi5`
- At least one SSH public key in `~/.ssh`, required for target builds by
  `config/target.exs`

## Run Locally

```bash
mix deps.get
iex -S mix
```

This starts the app on the host using the Wayland backend from
`config/host.exs`.

## Build Firmware

```bash
export MIX_TARGET=rpi5
mix firmware
```

`rpi4` should also work, but it is not currently tested and may require a
different `drm_card` value in `lib/nerves_emerge_demo.ex` and/or some changes to the nerves_system.

To bake WiFi settings into the firmware image with `mise`, put them in the
git-ignored `mise.local.toml` before building:

```toml
[env]
NERVES_WIFI_SSID = "your-ssid"
NERVES_WIFI_PSK = "your-passphrase"
NERVES_REGULATORY_DOMAIN = "US"
```

Then build firmware with an explicit target:

```bash
export MIX_TARGET=rpi5
mix firmware
```

If you are not using `mise`, you can still export the vars in your shell:

```bash
export MIX_TARGET=rpi5
export NERVES_WIFI_SSID="your-ssid"
export NERVES_WIFI_PSK="your-passphrase"
export NERVES_REGULATORY_DOMAIN="US"
mix firmware
```

`NERVES_WIFI_SSID` and `NERVES_WIFI_PSK` are read from `config/target.exs`
during the build. `WIFI_SSID`, `WIFI_PSK`, `WIFI_COUNTRY_CODE`, and
`WIFI_REGULATORY_DOMAIN` are also accepted as fallback names. If no PSK is set,
the network is treated as open.

## Test

```bash
mix test
```

## Use The App

- The viewport renders an animated background and two counter rows.
- Pressing `+` and `-` dispatches `Solve` events to the counter controller.
- The displayed count updates from the exposed state in `NervesEmergeDemo.State`.

## Project Layout

`lib/nerves_emerge_demo.ex` is the viewport entrypoint. It mounts the app and
renders the UI with `Emerge`.

`lib/nerves_emerge_demo/state.ex` defines the top-level `Solve` app and wires in
the counter controller.

`lib/nerves_emerge_demo/counter_controller.ex` owns the increment and decrement
event handlers.

`lib/nerves_emerge_demo/application.ex` starts the state process and viewport
under the supervision tree.

## Notes

- host mode uses the Wayland backend
- target mode uses the DRM backend
- `rootfs_overlay/etc/iex.exs` enables `Toolshed` in the target IEx session

## References

- [Emerge](https://hexdocs.pm/emerge)
- [Solve](https://hexdocs.pm/solve)
- [Nerves](https://hexdocs.pm/nerves/getting-started.html)

## License

Licensed under the Apache License, Version 2.0. See `LICENSE`.
