defmodule TenExTakeHome.ApiCalls do
  @moduledoc """
  This module allows creating and reading API Calls
  that were made to Marvel API. As seen in requirements,
  we just need to save and retrieve them.
  """
  import Ecto.Query, warn: false

  alias TenExTakeHome.Repo
  alias TenExTakeHome.ApiCalls.ApiCall

  @spec create_api_call(map()) :: {:ok, ApiCall.t()} | {:error, ApiCall.t()}
  def create_api_call(attrs \\ %{}) do
    %ApiCall{}
    |> ApiCall.changeset(attrs)
    |> Repo.insert()
  end

  # artibrary "take all calls from last hour" as default
  @doc """
  Gets all API calls inserted between now and {unit, time} in the past.
  If given no parameters it will collect all API Calls from previous hour.
  """
  @spec get_api_calls_by_time({atom(), non_neg_integer()}) :: list()
  def get_api_calls_by_time({unit, time} \\ {:hour, 1}) do
    time_ago = DateTime.utc_now() |> DateTime.add(-1 * time, unit)

    ApiCall
    |> where([ac], ac.inserted_at >= ^time_ago)
    |> Repo.all()
  end
end
