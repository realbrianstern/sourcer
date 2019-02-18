defmodule Hud.OscSender do
  use GenServer

  @spec start_link({port(), :inet.port_number()}) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(send_port) do
    GenServer.start_link(__MODULE__, send_port, name: __MODULE__)
  end

  @spec init(:inet.port_number()) :: {:ok, {port(), :inet.port_number()}}
  def init(send_port) do
    {:ok, socket} = :gen_udp.open(0, [:binary, ip: {127, 0, 0, 1}, active: false])

    # Replace with LibCluster
    Node.connect(:mainframe@localhost)

    Conduit.listen_topic("bitwig_osc")
    Conduit.add_subscriber(__MODULE__)
    {:ok, {socket, send_port}}
  end

  def handle_info({"bitwig_osc", data}, {socket, send_port}) do
    IO.inspect(data)
    :gen_udp.send(socket, {127, 0, 0, 1}, send_port, data)
    {:noreply, {socket, send_port}}
  end
end
