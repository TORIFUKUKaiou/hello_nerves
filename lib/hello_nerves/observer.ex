defmodule HelloNerves.Observer do
  use GenServer

  require Logger

  @input_pin HelloNerves.Util.input_pin()

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 1}, state) do
    Logger.debug("Received rising event on pin #{@input_pin}")
    HelloNerves.Led.Lighter.start_random()
    {:noreply, state ++ [1]}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 0}, state) do
    Logger.debug("Received falling event on pin #{@input_pin}")
    HelloNerves.Led.Lighter.stop_random()
    {:noreply, state ++ [0]}
  end
end
