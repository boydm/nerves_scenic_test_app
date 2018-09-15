defmodule SnTest do
  @moduledoc """
  Documentation for SnTest.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # load the viewport configuration from config
    main_viewport_config = Application.get_env(:sn_test, :viewport)

    # start the application with the viewport
    children = [
      supervisor(SnTest.Sensor.Supervisor, []),
      supervisor(Scenic, [viewports: [main_viewport_config]]),
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
  
end
