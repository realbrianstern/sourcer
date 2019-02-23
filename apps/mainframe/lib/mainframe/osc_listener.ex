defmodule Mainframe.OscListener do
  use GenServer

  @spec start_link(:inet.port_number()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(osc_listen_port) do
    GenServer.start_link(__MODULE__, osc_listen_port, name: __MODULE__)
  end

  @spec init(:inet.port_number()) :: :ignore | {:ok, port()}
  def init(osc_listen_port) do
    :gen_udp.open(osc_listen_port, [:binary, ip: {127, 0, 0, 1}, active: true])
  end

  def handle_info({:udp, _socket, _address, _port, data}, socket) do
    Conduit.broadcast("bitwig_osc", data)
    IO.inspect("__RECEIVED__")
    {:noreply, socket}
  end
end
