use Mix.Config

config :hud,
  osc_send_port: 9001

config :libcluster,
  topologies: [
    sourcer: [
      strategy: Cluster.Strategy.Gossip,
      config: [
        port: 45892,
        multicast_addr: "230.1.1.251",
        secret: "somepassword"
      ]
    ]
  ]
