defmodule TenExTakeHomeWeb.Live.CharactersLive do
  use TenExTakeHomeWeb, :live_view

  alias TenExTakeHome.Marvel.HttpClient

  def mount(_params, _session, socket) do
    default_assigns = get_default_assigns()

    {:ok, assign(socket, default_assigns)}
  end

  defp get_default_assigns() do
    characters =
      case HttpClient.get_characters() do
        {:ok, characters} -> characters
        {:error, _} -> []
      end

    [characters: characters]
  end
end
