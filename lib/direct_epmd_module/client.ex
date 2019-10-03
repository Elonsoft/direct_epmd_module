defmodule DirectEpmdModule.Client do
  @moduledoc """
  Example client.

  May be used to connect to another node.
  """

  use DirectEpmdModule, port: Application.get_env(:direct_epmd_module, :port)
end
