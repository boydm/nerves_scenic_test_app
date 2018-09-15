use Mix.Config

config :sn_test, :viewport, %{
      name: :main_viewport,
      size: {700, 600},
      default_scene: {SnTest.Scene.Primitives, nil},
      drivers: [
        %{
          module: Scenic.Driver.Glfw,
          name: :glfw,
          opts: [resizeable: false, title: "ElixirConf 2018"],
        }
      ]
    }
