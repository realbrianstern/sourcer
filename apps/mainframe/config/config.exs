use Mix.Config

config :mainframe,
  osc_listen_port: 9000

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
