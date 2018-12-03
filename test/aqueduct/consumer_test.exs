defmodule Aqueduct.ConsumerTest do
  use ExUnit.Case
  use Mockery
  alias KafkaEx.Protocol.Fetch.Message


  @topic "topic"
  @partition 0


  setup do
    {:ok, state} = Aqueduct.Consumer.init(@topic, @partition)
    {:ok, %{state: state}}
  end

  test "it consumes a message set & acks it w/ async_commit", %{state: state} do

    mock(Aqueduct.Consumer, :handle_message_set, :ok)

    message_set = [%Message{offset: 0, value: "{\"version\":\"1\"}"}, %Message{offset: 1, value: "{\"version\":\"2\"}"}]
    {response, _new_state} = Aqueduct.Consumer.handle_message_set(message_set, state)
    assert response ==
        :async_commit
  end
end
