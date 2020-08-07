defmodule BlockfiExercise.Application do
  @moduledoc """
    This module starts the application by starting all the processes needed to accomplish the task
  """

  use Application
  @consumers 12

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # registers the table to lookup for the Producer-Consumer's id
    Registry.start_link(keys: :unique, name: ProducerConsumers)

    child_consumers =
      for id <- 1..@consumers do
        Supervisor.child_spec(BlockfiExercise.Consumer, id: id)
      end

    children =
      [
        BlockfiExercise.Producer,
        BlockfiExercise.ProducerConsumer,
        Plug.Cowboy.child_spec(
          scheme: :http,
          plug: BlockfiExercise.EndPoint,
          options: [port: 4001]
        )
      ] ++ child_consumers

    opts = [strategy: :one_for_one, name: BlockfiExercise.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
