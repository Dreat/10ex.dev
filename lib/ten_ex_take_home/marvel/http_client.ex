defmodule TenExTakeHome.Marvel.HttpClient do
  # could remove `characters` if we would like to use more of this API
  # keeping it for the sake of simplicity
  @base_url "http://gateway.marvel.com/v1/public/characters"
  @page_size 20

  def get_characters(page_number) do
    url = "#{@base_url}?#{get_auth_params()}#{get_page_param(page_number)}"

    with {:ok, response} <- :get |> Finch.build(url) |> Finch.request(TenExTakeHome.Finch),
         {:ok, results} <- Jason.decode(response.body) do
      {:ok, parse_characters(results)}
    else
      # in real app we could probably have better error handling
      error -> {:error, error}
    end
  end

  def construct_hash(timestamp, priv_key, pub_key) do
    :crypto.hash(:md5, "#{timestamp}#{priv_key}#{pub_key}") |> Base.encode16(case: :lower)
  end

  defp get_auth_params() do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()

    priv_key = Application.get_env(:ten_ex_take_home, :marvel_priv_key)
    pub_key = Application.get_env(:ten_ex_take_home, :marvel_pub_key)

    hash = construct_hash(timestamp, priv_key, pub_key)

    "ts=#{timestamp}&apikey=#{pub_key}&hash=#{hash}"
  end

  defp get_page_param(page_number) do
    offset = (page_number - 1) * @page_size

    "&offset=#{offset}"
  end

  # for more complex data I would use struct and possibly Poison.decode
  # this works good enough to just get names and pass them around
  defp parse_characters(%{"data" => %{"results" => results}}) do
    Enum.map(results, fn r -> r["name"] end)
  end
end
