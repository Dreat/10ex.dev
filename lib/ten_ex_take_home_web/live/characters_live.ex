defmodule TenExTakeHomeWeb.Live.CharactersLive do
  use TenExTakeHomeWeb, :live_view

  alias TenExTakeHome.Characters

  def mount(_params, _session, socket) do
    default_assigns = get_default_assigns()

    {:ok, assign(socket, default_assigns)}
  end

  def handle_event("next_page", _params, %{assigns: %{page_number: page_number}} = socket) do
    new_page_number = page_number + 1

    new_characters = get_characters(new_page_number)

    {:noreply, assign(socket, page_number: new_page_number, characters: new_characters)}
  end

  def handle_event("previous_page", _params, %{assigns: %{page_number: page_number}} = socket) do
    new_page_number = page_number - 1

    new_characters = get_characters(new_page_number)

    {:noreply, assign(socket, page_number: new_page_number, characters: new_characters)}
  end

  defp get_default_assigns() do
    page_number = 1

    characters = get_characters(page_number)

    [characters: characters, page_number: page_number]
  end

  defp get_characters(page_number) do
    case Characters.get_characters(page_number) do
      {:ok, characters} -> characters
      {:error, _} -> []
    end
  end
end
