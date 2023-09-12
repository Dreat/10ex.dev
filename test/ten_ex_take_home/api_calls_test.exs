defmodule TenExTakeHome.ApiCallsTest do
  use TenExTakeHome.DataCase

  alias TenExTakeHome.Factory
  alias TenExTakeHome.ApiCalls

  describe "get_api_calls_by_time/1" do
    test "with no parameters it returns ApiCalls from previous hour" do
      t1 = DateTime.utc_now() |> DateTime.add(-30, :minute)
      t2 = DateTime.utc_now() |> DateTime.add(-2, :hour)
      t3 = DateTime.utc_now() |> DateTime.add(-3, :hour)

      expected_api_calls =
        [Factory.insert(:api_call), Factory.insert(:api_call, inserted_at: t1)] |> Enum.sort()

      Factory.insert(:api_call, inserted_at: t2)
      Factory.insert(:api_call, inserted_at: t3)

      result = ApiCalls.get_api_calls_by_time() |> Enum.sort()

      assert result == expected_api_calls
    end

    test "gets APICalls with specified time frame" do
      t1 = DateTime.utc_now() |> DateTime.add(-30, :minute)
      t2 = DateTime.utc_now() |> DateTime.add(-15, :minute)
      t3 = DateTime.utc_now() |> DateTime.add(-50, :minute)

      expected_api_calls =
        [
          Factory.insert(:api_call),
          Factory.insert(:api_call, inserted_at: t1),
          Factory.insert(:api_call, inserted_at: t2)
        ]
        |> Enum.sort()

      Factory.insert(:api_call, inserted_at: t3)

      result = ApiCalls.get_api_calls_by_time({:minute, 45}) |> Enum.sort()

      assert result == expected_api_calls
    end
  end
end
