defmodule HelloNerves.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Children for all targets
        # Starts a worker by calling: HelloNerves.Worker.start_link(arg)
        # {HelloNerves.Worker, arg},
      ] ++ children(Nerves.Runtime.mix_target())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloNerves.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  defp children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: HelloNerves.Worker.start_link(arg)
      # {HelloNerves.Worker, arg},
      HelloNerves.Scheduler
    ]
  end

  defp children(_target) do
    if Application.get_env(:hello_nerves, :mix_tasks_upload_hotswap_enabled) do
      System.cmd("epmd", ["-daemon"])
      Node.start(:"pi@nerves-rpi2.local")
      Node.set_cookie(Application.get_env(:mix_tasks_upload_hotswap, :cookie))
    end

    [
      # Children for all targets except host
      # Starts a worker by calling: HelloNerves.Worker.start_link(arg)
      # {HelloNerves.Worker, arg},
      {HelloNerves.Blinker, name: HelloNerves.Blinker},
      {HelloNerves.Observer, name: HelloNerves.Observer},
      {HelloNerves.SetInterrupter, name: HelloNerves.SetInterrupter},
      {HelloNerves.Led.Lighter, name: HelloNerves.Led.Lighter},
      HelloNerves.Scheduler
    ]
  end
end
