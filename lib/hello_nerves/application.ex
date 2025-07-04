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
      ] ++ target_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloNerves.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  if Mix.target() == :host do
    defp target_children() do
      [
        # Children that only run on the host during development or test.
        # In general, prefer using `config/host.exs` for differences.
        #
        # Starts a worker by calling: Host.Worker.start_link(arg)
        # {Host.Worker, arg},
        AwesomeNerves.Scheduler
      ]
    end
  else
    defp target_children() do
      if Application.get_env(:hello_nerves, :mix_tasks_upload_hotswap_enabled) do
        System.cmd("epmd", ["-daemon"])
        Node.start(:"pi@nerves-rpi2.local")
        Node.set_cookie(Application.get_env(:mix_tasks_upload_hotswap, :cookie))
      end

      [
        # Children for all targets except host
        # Starts a worker by calling: Target.Worker.start_link(arg)
        # {Target.Worker, arg},
        {AwesomeNerves.Blinker, name: AwesomeNerves.Blinker},
        {AwesomeNerves.Observer, name: AwesomeNerves.Observer},
        {AwesomeNerves.SetInterrupter, name: AwesomeNerves.SetInterrupter},
        {AwesomeNerves.Led.Lighter, name: AwesomeNerves.Led.Lighter},
        AwesomeNerves.Scheduler
      ]
    end
  end
end
