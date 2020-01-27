defmodule HelloNerves.Led.Lighter do
  use GenServer

  require Logger

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast(:start_random, state) do
    pid = spawn(fn -> HelloNerves.Led.SevenSeg.random_forever() end)

    {:noreply, state ++ [pid]}
  end

  @impl true
  def handle_cast(:stop_random, state) do
    Logger.debug("stop_random: #{inspect(state)}")
    state |> List.last() |> stop_random()

    dice()

    {:noreply, state}
  end

  def start_random() do
    GenServer.cast(__MODULE__, :start_random)
  end

  def stop_random() do
    GenServer.cast(__MODULE__, :stop_random)
  end

  defp stop_random(pid) when is_pid(pid), do: Process.exit(pid, :killed)

  defp stop_random(_pid), do: nil

  defp dice do
    HelloNerves.Led.SevenSeg.random()
  end
end
