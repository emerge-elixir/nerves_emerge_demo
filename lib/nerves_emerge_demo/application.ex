defmodule NervesEmergeDemo.Application do
  @moduledoc false

  use Application

  @env Mix.env()

  @impl true
  def start(_type, _args) do
    children = children(@env)
    opts = [strategy: :one_for_one, name: NervesEmergeDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def children(:test), do: []
  def children(_env), do: [state_child(), NervesEmergeDemo]

  defp state_child do
    %{
      id: NervesEmergeDemo.State,
      start: {NervesEmergeDemo.State, :start_link, [[name: NervesEmergeDemo.State]]},
      type: :worker,
      restart: :permanent
    }
  end
end
