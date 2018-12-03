defmodule Aqueduct.StreamFlattenerTest do
  use ExUnit.Case
  alias KafkaEx.Protocol.Fetch.Message

  test "flattens out the stream to get the messages" do
    message_set = [%Message{offset: 0, value: "{\"version\":\"1\"}"}, %Message{offset: 1, value: "{\"version\":\"2\"}"}]
    value = Aqueduct.StreamFlattener.flatten(message_set)
    assert value == ["{\"version\":\"1\"}", "{\"version\":\"2\"}"]
  end
end
