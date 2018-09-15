use Mix.Config

config :sn_test, :viewport, %{
      name: :main_viewport,
      size: {700, 600},
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
          # opts: [
          #   device: "Advanced Silicon S.A CoolTouch(TM) System",
          #   calibration: {{0.058594,0,0},{0.033020,0,0}}
          # ],
        }
      ]
    }