defmodule BlockfiExercise.EndPoint do
  @moduledoc """
    This module receives the mocked images by an endpoint to send them to the Producer
  """
  use Plug.Router
  alias BlockfiExercise.Producer
  plug(:match)
  plug(Plug.Parsers, parsers: [:multipart], json_decoder: Poison)
  plug(:dispatch)
  @max_bandwith_in_bytes 120_000_000
  @min_bandwith_in_bytes 1_000_000
  post "/images/upload" do
    {status, body} =
      case conn.body_params do
        event -> {200, process_events(event)}
      end

    send_resp(conn, status, body)
  end

  defp process_events(event) do
    event = Map.put(event, :size, Enum.random(@min_bandwith_in_bytes..@max_bandwith_in_bytes))
    Producer.add_event(event)
    Poison.encode!(%{response: "Received Events!"})
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
