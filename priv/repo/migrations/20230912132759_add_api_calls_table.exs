defmodule TenExTakeHome.Repo.Migrations.AddApiCallsTable do
  use Ecto.Migration

  def up do
    create table(:api_calls) do
      add :call, :string, null: false
      timestamps()
    end
  end

  def down do
    drop table(:api_calls)
  end
end
