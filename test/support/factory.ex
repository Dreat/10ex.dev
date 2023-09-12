defmodule TenExTakeHome.Factory do
  use ExMachina.Ecto, repo: TenExTakeHome.Repo

  alias TenExTakeHome.ApiCalls.ApiCall

  def api_call_factory do
    %ApiCall{
      call: "get_characters",
      inserted_at: DateTime.utc_now()
    }
  end
end
