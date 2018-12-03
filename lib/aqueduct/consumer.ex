defmodule Aqueduct.Consumer do
  use KafkaEx.GenConsumer
  require Logger

  alias KafkaEx.Protocol.Fetch.Message

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do
    for %Message{value: message} <- message_set do
      Logger.debug(fn -> "message: " <> inspect(message) end)
    end

    {:async_commit, state}
  end
end
