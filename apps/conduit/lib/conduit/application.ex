defmodule Conduit.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub.PG2, name: Conduit.PubSub, pool_size: 1},
      Conduit.Manager
    ]

    opts = [strategy: :one_for_one, name: Conduit.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
