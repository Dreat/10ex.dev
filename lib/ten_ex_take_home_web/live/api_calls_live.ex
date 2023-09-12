defmodule TenExTakeHomeWeb.Live.ApiCallsLive do
  use TenExTakeHomeWeb, :live_view

  alias TenExTakeHome.ApiCalls

  @default_time {:hour, 1}

  def mount(_params, _session, socket) do
    default_assigns = get_default_assigns()

    {:ok, assign(socket, default_assigns)}
  end

  defp get_default_assigns() do
    api_calls_count =
      @default_time
      |> ApiCalls.get_api_calls_by_time()
      |> Enum.count()

    [api_calls_count: api_calls_count]
  end
end
