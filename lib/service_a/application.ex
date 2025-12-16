defmodule ServiceA.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      example_cluster: [
        strategy: Cluster.Strategy.DNSPoll,
        config: [
          polling_interval: 1000,
          # <--- QUAN TRỌNG: Đây là tên DNS trong Swarm
          query: "tasks.service_b",
          # Tên app của node B
          node_basename: "service_b"
        ]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: ServiceA.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: ServiceA.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
