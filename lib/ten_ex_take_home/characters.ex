defmodule TenExTakeHome.Characters do
  alias TenExTakeHome.ApiCalls
  alias TenExTakeHome.Marvel.HttpClient

  def get_characters() do
    with {:commit, val} <-
           Cachex.fetch(:marvel_cache, "characters", fn ->
             {:commit, HttpClient.get_characters()}
           end) do
      log_successful_api_call()
      Cachex.expire(:marvel_cache, "characters", :timer.seconds(3600))
      val
    else
      {:ok, val} ->
        val

      a ->
        IO.inspect(a)
        nil
    end
  end

  # this could go to a different module, but for the sake of time
  # and simplicity I will leave it here
  defp log_successful_api_call() do
    # if we wanted to log other calls, we would parametrize it
    call = "get_characters"

    # let's assume this won't fail
    ApiCalls.create_api_call(%{call: call})
  end
end
