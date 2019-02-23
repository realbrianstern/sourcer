defmodule Mainframe.Application do
  @moduledoc false

  use Application

  @spec start(any(), any()) :: {:error, any()} | {:ok, pid()}
  def start(_type, _args) do
    children = [
      {Mainframe.OscListener, Application.get_env(:mainframe, :osc_listen_port)},
      {Cluster.Supervisor,
       [Application.get_env(:libcluster, :topologies), [name: Mainframe.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: Mainframe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
