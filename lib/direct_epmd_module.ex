defmodule DirectEpmdModule do
  @moduledoc """
  Instead of port mapper.

  The module used as -epmd_module.

  For more info on distribution client refer to the docs:
  http://erlang.org/doc/apps/erts/alt_disco.html#discovery-module

  If you want to learn how distribution works, see
  http://erlang.org/doc/apps/erts/alt_dist.html#distribution-module
  """

  defmacro __using__(opts) do
    port = opts[:port] || 1337
    dist_version = opts[:dist_version] || 5

    quote do
      @port unquote(port)
      @dist_version unquote(dist_version)

      defdelegate start_link, to: DirectEpmdModule

      defdelegate register_node(name, port), to: DirectEpmdModule
      defdelegate register_node(name, port, driver), to: DirectEpmdModule

      def address_please(name, host, address_family) do
        DirectEpmdModule.address_please(name, host, address_family, @port, @dist_version)
      end

      def port_please(name, host, timeout) do
        DirectEpmdModule.port_please(name, host, timeout, @port, @dist_version)
      end

      def port_please(name, host) do
        DirectEpmdModule.port_please(name, host, @port, @dist_version)
      end

      def names(hostname) do
        DirectEpmdModule.names(hostname)
      end
    end
  end

  def start_link, do: :ignore

  def register_node(_name, _port, _driver \\ :inet) do
    {:ok, 0}
  end

  def address_please(_name, _host, address_family, port, dist_version) do
    {:ok, loopback_for(address_family), port, dist_version}
  end

  def port_please(_name, _host, _timeout \\ :infinity, port, dist_version) do
    {:ok, port, dist_version}
  end

  def names(_hostname) do
    {:error, :address}
  end

  defp loopback_for(:inet), do: {127, 0, 0, 1}
  defp loopback_for(:inet6), do: {0, 0, 0, 0, 0, 0, 0, 1}
end
