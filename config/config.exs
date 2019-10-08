import Mix.Config

config :direct_epmd_module, port: String.to_integer(System.get_env("DEM_PORT", "1337"))
