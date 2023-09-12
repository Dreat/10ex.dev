{:ok, _} = Application.ensure_all_started(:ex_machina)

Mimic.copy(TenExTakeHome.Marvel.HttpClient)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TenExTakeHome.Repo, :manual)
