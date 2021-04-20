defmodule Core.Schemata do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Schemata
    end
  end
end
