use Mix.Config

config :sn_test, :viewport, %{
      name: :main_viewport,
      size: {700, 600},
      default_scene: {SnTest.Scene.Primitives, nil},
      drivers: [
        %{
          module: Scenic.Driver.Nerves.Rpi,
        },
      ]
    }