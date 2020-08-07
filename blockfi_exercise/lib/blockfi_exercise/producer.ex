defmodule BlockfiExercise.Producer do
  use GenStage

  @moduledoc """
    This module generates events and dispatches them to be consumed by the Producer-Consumer
  """

  def start_link([]) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def add_event(event) do
    GenStage.cast(__MODULE__, {:add_event, event})
  end

  def init(state), do: {:producer, state}

  def handle_cast({:add_event, event}, state) do
    {:noreply, [event], state}
  end

  def handle_demand(demand, state) when demand > 0 do
    {images, state} = Enum.split(state, demand)
    {:noreply, images, state}
  end
end
