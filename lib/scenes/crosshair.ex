defmodule SnTest.Scene.Crosshair do
  use Scenic.Scene

  alias Scenic.Graph
  alias Scenic.ViewPort
  alias SnTest.Component.Nav
  import Scenic.Primitives

#  import IEx

  @graph Graph.build(  )
    |> rect( {1000, 1000}, id: :target )
    |> text("Touch the screen to start", id: :pos, translate: {20,80})
    |> line( {{0, 100}, {1000,100}}, stroke: {4, :white}, id: :cross_hair_h, hidden: true )
    |> line( {{100, 0}, {100,1000}}, stroke: {4, :white}, id: :cross_hair_v, hidden: true )
    |> Nav.add_to_graph( __MODULE__ )

  #============================================================================
  # setup

  #--------------------------------------------------------
  def init( _, opts ) do
    # Get the viewport dimensions
    {:ok, %ViewPort.Status{size: {width,height}}} = opts[:viewport]
    |> ViewPort.info()

    push_graph( @graph )

    {:ok, {@graph, width, height}}
  end

  #============================================================================
  # event handlers

  #--------------------------------------------------------
  def handle_input( {:cursor_button, {:left, :press, _, {x,y}}}, context, {graph, w, h} ) do
    pos = "x: #{:erlang.float_to_binary(x * 1.0, [decimals: 1])}, " <> 
    "y: #{:erlang.float_to_binary(y * 1.0, [decimals: 1])}"

    graph = graph
    |> Graph.modify( :target, &rect(&1, {w,h}) )
    |> Graph.modify( :cross_hair_h, &line(&1, {{0,y}, {w,y}}, hidden: false) )
    |> Graph.modify( :cross_hair_v, &line(&1, {{x,0}, {x,h}}, hidden: false) )
    |> Graph.modify( :pos, &text(&1, pos) )
    |> push_graph()

    ViewPort.capture_input( context, [:cursor_button, :cursor_pos])

    {:noreply, {graph, w, h}}
  end

  #--------------------------------------------------------
  def handle_input( {:cursor_button, {:left, :release, _, {x,y}}}, context, {graph, w, h} ) do
    pos = "x: #{:erlang.float_to_binary(x * 1.0, [decimals: 1])}, " <> 
    "y: #{:erlang.float_to_binary(y * 1.0, [decimals: 1])}"

    graph = graph
    |> Graph.modify( :cross_hair_h, &update_opts(&1, hidden: true) )
    |> Graph.modify( :cross_hair_v, &update_opts(&1, hidden: true) )
    |> Graph.modify( :pos, &text(&1, pos) )
    |> push_graph()

    ViewPort.release_input( context, [:cursor_button, :cursor_pos] )

    {:noreply, {graph, w, h}}
  end

  #--------------------------------------------------------
  def handle_input( {:cursor_pos, {x,y}}, _context, {graph, w, h} ) do
    pos = "x: #{:erlang.float_to_binary(x * 1.0, [decimals: 1])}, " <> 
    "y: #{:erlang.float_to_binary(y * 1.0, [decimals: 1])}"

    graph = graph
    |> Graph.modify( :cross_hair_h, &line(&1, {{0,y}, {w,y}}) )
    |> Graph.modify( :cross_hair_v, &line(&1, {{x,0}, {x,h}}) )
    |> Graph.modify( :pos, &text(&1, pos) )
    |> push_graph()
    {:noreply, {graph, w, h}}
  end

  def handle_input( msg, _, state ) do
IO.puts "Unhandled calibrate msg: #{inspect(msg)}"
    {:noreply, state}
  end

end