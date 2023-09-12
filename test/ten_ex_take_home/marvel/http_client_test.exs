defmodule TenExTakeHome.Marvel.HttpClientTest do
  use TenExTakeHome.DataCase

  alias TenExTakeHome.Marvel.HttpClient

  test "construct_hash" do
    # from Marvel's API auth guide
    timestamp = "1"
    priv_key = "abcd"
    pub_key = "1234"
    expected_hash = "ffd275c5130566a2916217b101f26150"
    result = HttpClient.construct_hash(timestamp, priv_key, pub_key)

    assert expected_hash == result
  end
end
