defmodule BlockfiExercise.Consumer do
  use GenStage

  @moduledoc """
    This module has two jobs:\n
  \n
    1- It is always asking for an image to be uploaded\n
    2- It uploads the image to the AWS once it gets it\n
  """
  @bandwith_in_bytes 120_000_000
  def start_link(_) do
    GenStage.start_link(__MODULE__, [])
  end

  def init(_) do
    {:consumer, %{counter: 0}, subscribe_to: [BlockfiExercise.ProducerConsumer]}
  end

  def handle_events([], _from, state) do
    {:noreply, [], state}
  end

  @doc """
  receives the image that was demanded, uploads it and lets know the Producer-Consumer he has released bandwith to be used
    - list: a single element list which has the image to be uploaded
    - from: the pid of the Producer-Consumer who sent the event
    - state: current state of the Consumer
  """
  def handle_events([image | _], _from, state) do
    [{pid, _}] = Registry.lookup(ProducerConsumers, :id)
    # emulates the time it takes to upload an image
    Process.sleep(Kernel.round(image.size / @bandwith_in_bytes) * 1000)
    send(pid, {:finished, image.size})
    {:noreply, [], state}
  end
end
