defmodule BitwigBroadcast.Application do
  @moduledoc false

  use Application

  @spec start(any(), any()) :: {:error, any()} | {:ok, pid()}
  def start(_type, _args) do
    children = [
      {BitwigBroadcast.OscListener, Application.get_env(:bitwig_broadcast, :osc_listen_port)}
    ]

    opts = [strategy: :one_for_one, name: BitwigBroadcast.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
