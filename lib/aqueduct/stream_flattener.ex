defmodule Aqueduct.StreamFlattener do
  # input [%Message{offset: 0, value: "{\"version\":\"1\"}"}, %Message{offset: 0, value: "{\"version\":\"2\"}"}]
  # output [%{"version" => "1"}, %{"version" => "2"}]

  alias KafkaEx.Protocol.Fetch.Message

  def flatten(message_set) do
    message_set
    |> Enum.map(&extract_message/1)
    |> Enum.map(&[&1, "\n"])
    |> Enum.into(File.stream!("output.txt", [:write, :utf8]))
  end

  defp extract_message(%Message{offset: _, value: data}) do data end
end
