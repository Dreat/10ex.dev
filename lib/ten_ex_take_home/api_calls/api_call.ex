defmodule TenExTakeHome.ApiCalls.ApiCall do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:call]

  schema "api_calls" do
    field :call, :string

    timestamps()
  end

  @doc false
  def changeset(api_call, attrs) do
    api_call
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
