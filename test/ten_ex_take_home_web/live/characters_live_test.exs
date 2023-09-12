defmodule TenExTakeHomeWeb.Live.CharactersLiveTest do
  use TenExTakeHomeWeb.ConnCase, async: false
  use Mimic

  import Phoenix.LiveViewTest

  @characters ["first", "second", "third"]

  # needed to use mimic in cachex
  setup :set_mimic_global

  describe "happy path tests" do
    setup do
      Cachex.clear!(:marvel_cache)

      TenExTakeHome.Marvel.HttpClient
      |> stub(:get_characters, fn -> {:ok, @characters} end)

      :ok
    end

    test "shows all characters in a list", %{conn: conn} do
      view = mount_liveview(conn)

      for character <- @characters do
        assert has_element?(view, "li##{character}")
      end
    end
  end

  describe "failures" do
    setup do
      Cachex.clear!(:marvel_cache)

      TenExTakeHome.Marvel.HttpClient
      |> stub(:get_characters, fn -> {:error, :timeout} end)

      :ok
    end

    test "renders an empty list if API call failed", %{conn: conn} do
      view = mount_liveview(conn)

      for character <- @characters do
        refute has_element?(view, "li##{character}")
      end
    end
  end

  defp mount_liveview(conn) do
    {:ok, view, _html} = live(conn, "/")
    view
  end
end
