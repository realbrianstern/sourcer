defmodule Hud.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Hud.OscSender, Application.get_env(:hud, :osc_send_port)},
      {Cluster.Supervisor,
       [Application.get_env(:libcluster, :topologies), [name: Hud.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: Hud.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
