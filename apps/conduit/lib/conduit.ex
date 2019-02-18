defmodule Conduit do
  def add_subscriber(subscriber) do
    Conduit.Manager.add_subscriber(subscriber)
  end

  def listen_topic(topic) do
    Conduit.Manager.listen_topic(topic)
  end

  def broadcast(topic, data) do
    Conduit.Manager.broadcast(topic, data)
  end
end
