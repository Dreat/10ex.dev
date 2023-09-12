defmodule TenExTakeHome.Cache.Supervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      %{
        id: :marvel_cache,
        start: {Cachex, :start_link, [:marvel_cache, []]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
