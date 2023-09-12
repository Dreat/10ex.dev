defmodule TenExTakeHome.Marvel.Impl do
  alias TenExTakeHome.Marvel.HttpClient

  # could remove `characters` if we would like to use more of this API
  # keeping it for the sake of simplicity
  @base_url "http://gateway.marvel.com/v1/public/characters"

  @behaviour HttpClient

  @impl HttpClient
  def get_characters() do
    url = "#{@base_url}?#{get_auth_params()}"

    with {:ok, response} <- :get |> Finch.build(url) |> Finch.request(TenExTakeHome.Finch),
         {:ok, results} <- Jason.decode(response.body) do
      {:ok, parse_characters(results)}
    else
      # in real app we could probably have better error handling
      error -> {:error, error}
    end
  end

  defp get_auth_params() do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()

    priv_key = Application.get_env(:ten_ex_take_home, :marvel_priv_key)
    pub_key = Application.get_env(:ten_ex_take_home, :marvel_pub_key)

    hash = :crypto.hash(:md5, "#{timestamp}#{priv_key}#{pub_key}") |> Base.encode16(case: :lower)

    "ts=#{timestamp}&apikey=#{pub_key}&hash=#{hash}"
  end

  # for more complex data I would use struct and possibly Poison.decode
  # this works good enough to just get names and pass them around
  defp parse_characters(%{"data" => %{"results" => results}}) do
    Enum.map(results, fn r -> r["name"] end)
  end
end