defmodule HelloNerves.Observer do
  use GenServer

  require Logger

  @input_pin HelloNerves.Util.input_pin()
  @weather_input_pin HelloNerves.Util.weather_input_pin()

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    HelloNerves.Scheduler.start_link()
    {:ok, %{last_time: Time.utc_now()}}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 1}, state) do
    Logger.debug("Received rising event on pin #{@input_pin}")
    HelloNerves.Led.Lighter.start_random()
    {:noreply, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 0}, state) do
    Logger.debug("Received falling event on pin #{@input_pin}")
    HelloNerves.Led.Lighter.stop_random()
    {:noreply, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @weather_input_pin, _timestamp, 1}, state) do
    # Logger.debug("Received rising event on pin #{@weather_input_pin}")
    button_history = Map.get(state, @weather_input_pin, [])
    {:noreply, Map.merge(state, %{@weather_input_pin => button_history ++ [1]})}
  end

  @impl true
  def handle_info({:circuits_gpio, @weather_input_pin, _timestamp, 0}, state) do
    # Logger.debug("Received falling event on pin #{@weather_input_pin}")
    # Logger.debug(inspect(state))
    button_history = Map.get(state, @weather_input_pin, [])
    last_time = Map.get(state, :last_time)
    now = Time.utc_now()

    if List.last(button_history) == 1 && Time.diff(now, last_time) > 15 do
      spawn(HelloNerves, :sound_forecast, [400_030])
      {:noreply, Map.merge(state, %{@weather_input_pin => button_history ++ [0], last_time: now})}
    else
      {:noreply, Map.merge(state, %{@weather_input_pin => button_history ++ [0]})}
    end
  end
end
