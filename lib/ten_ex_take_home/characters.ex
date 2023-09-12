defmodule TenExTakeHome.Characters do
  alias TenExTakeHome.Marvel.HttpClient

  def get_characters() do
    with {:commit, val} <-
           Cachex.fetch(:marvel_cache, "characters", fn ->
             {:commit, HttpClient.get_characters()}
           end) do
      Cachex.expire(:marvel_cache, "characters", :timer.seconds(3600))
      val
    else
      {:ok, val} ->
        val

      _ ->
        nil
    end
  end
end
