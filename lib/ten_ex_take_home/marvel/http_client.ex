defmodule TenExTakeHome.Marvel.HttpClient do
  @callback get_characters() :: {:ok, list()} | {:error, any()}

  @implementation Application.compile_env!(:ten_ex_take_home, [__MODULE__, :impl])

  defdelegate get_characters(), to: @implementation
end
