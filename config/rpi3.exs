use Mix.Config

config :sn_test, :viewport, %{
      name: :main_viewport,
      size: {800, 480},
      opts: [scale: 1.2],
      default_scene: {SnTest.Scene.Primitives, nil},
      drivers: [
        %{
          module: Scenic.Driver.Nerves.Rpi,
        },
        %{
          module: Scenic.Driver.Nerves.Touch,
          opts: [
            device: "FT5406 memory based driver",
            calibration: {{1,0,0},{1,0,0}}
          ],
        }
      ]
    }