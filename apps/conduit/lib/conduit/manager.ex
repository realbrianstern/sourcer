defmodule Conduit.Manager do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def add_subscriber(subscriber) do
    GenServer.call(__MODULE__, {:add_subscriber, subscriber})
  end

  def listen_topic(topic) do
    GenServer.call(__MODULE__, {:listen_topic, topic})
  end

  def broadcast(topic, data) do
    GenServer.cast(__MODULE__, {:broadcast, topic, data})
  end

  @spec init(any()) :: {:ok, []}
  def init(_) do
    {:ok, []}
  end

  def handle_call({:add_subscriber, subscriber}, _from, subscribers) do
    {:reply, :ok, [subscriber | subscribers]}
  end

  def handle_call({:listen_topic, topic}, _from, state) do
    response = Phoenix.PubSub.subscribe(Conduit.PubSub, topic)
    {:reply, response, state}
  end

  def handle_cast({:broadcast, topic, data}, state) do
    Phoenix.PubSub.broadcast(Conduit.PubSub, topic, {topic, data})
    {:noreply, state}
  end

  def handle_info({topic, data}, subscribers) do
    Enum.each(subscribers, fn subscriber ->
      Process.send(subscriber, {topic, data}, [:noconnect])
    end)

    {:noreply, subscribers}
  end
end
