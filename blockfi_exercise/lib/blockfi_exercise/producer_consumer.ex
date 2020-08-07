defmodule BlockfiExercise.ProducerConsumer do
  use GenStage
  alias BlockfiExercise.Producer
  require Integer

  @bandwith_in_bytes 120_000_000

  @moduledoc """
    This module works as a middle point for the Producer and the Consumers, it has three jobs\n
    \n
    1- Provide the currently demanding Consumer with an image from the Producer\n
    2- Mantain the possible bandwith usage by the images to at most 10Mb/s (around 12MB per second)\n
    3- Queue up images that can't be processed due to bandwith usage to be processed later\n
  """

  defmodule State do
    defstruct [:bandwith, counter: 0, queue: :queue.new()]
  end

  def start_link(_) do
    GenStage.start_link(__MODULE__, @bandwith_in_bytes, name: __MODULE__)
  end

  @impl true
  def init(bandwith) do
    Registry.register(ProducerConsumers, :id, :producer_consumer)

    {:producer_consumer, %State{bandwith: bandwith},
     subscribe_to: [{BlockfiExercise.Producer, max_demand: 1}]}
  end

  @doc """
    this function uses the state to know how many images have been uploaded, also sends back an unprocessed image to the Producer for it
    to be processed again later

      - :finished: part of the arg, the atom used to match the handle_info
      - size: part of the arg, the size of the image processed
      - state: the current state of the Producer-Consumer
      - bandwith: part of the state, amount of bandwith currently being used
      - counter: part of the state, number of images uploaded by the model
      - queue: part of the state, queue of images waiting to be processed
  """
  @impl true
  def handle_info(
        {:finished, size},
        %State{bandwith: bandwith, counter: counter, queue: queue} = state
      ) do
    counter = counter + 1

    case :queue.out(queue) do
      {:empty, _} ->
        {:noreply, [], %State{state | bandwith: size + bandwith, counter: counter}}

      {{:value, image_queued}, new_queue} ->
        Producer.add_event(image_queued)

        {:noreply, [],
         %State{state | bandwith: size + bandwith, queue: new_queue, counter: counter}}
    end
  end

  @impl true

  def handle_events([], _from, state) do
    {:noreply, [], state}
  end

  @doc """
   Gets an image from the Producer and sends it to the current Consumer, if the bandwith in usage is too high, it queues it for later processing

      - list: a single element list with the image to be processed, there is only one image per demand
      - from: the pid of the Producer who sent the event
      - queue: part of the state, queue of images waiting to be processed
      - state: part of the state, the current state of the Producer-Consumer
  """
  def handle_events([image | _], _from, %State{queue: queue} = state) do
    case :queue.out(queue) do
      {:empty, _} ->
        send_event_to_consumer(image, state)

      {{:value, image_queued}, new_queue} ->
        new_queue = :queue.in(image, new_queue)
        send_event_to_consumer(image_queued, %State{state | queue: new_queue})
    end
  end

  defp send_event_to_consumer(image, %State{bandwith: bandwith, queue: queue} = state) do
    cond do
      bandwith - image.size >= 0 ->
        {:noreply, [image], %State{state | bandwith: bandwith - image.size}}

      true ->
        new_queue = :queue.in_r(image, queue)
        {:noreply, [], %State{state | queue: new_queue}}
    end
  end
end
