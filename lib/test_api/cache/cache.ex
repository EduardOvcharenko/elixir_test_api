defmodule TestApi.Cache.Cache do
  def start(name, opts \\ []) do
    :ets.new(name, opts)
    :ok
  rescue
    ArgumentError -> {:error, :already_started}
  end
end
