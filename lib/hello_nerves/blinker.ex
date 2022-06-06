defmodule HelloNerves.Blinker do
  use GenServer

  @moduledoc """
    Simple GenServer to control GPIO #18.
  """

  alias Circuits.GPIO
  require Logger

  @output_pin Application.compile_env(:hello_nerves, :output_pin, 18)

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    enable()

    {:ok, state}
  end

  @impl true
  def handle_cast(:enable, state) do
    Logger.info("Enabling LED")
    turn_on()

    {:noreply, state}
  end

  @impl true
  def handle_cast(:disable, state) do
    Logger.info("Disabling LED")
    turn_off()

    {:noreply, state}
  end

  def enable() do
    GenServer.cast(__MODULE__, :enable)
  end

  def disable() do
    GenServer.cast(__MODULE__, :disable)
  end

  defp turn_on do
    Circuits.GPIO.write(output_gpio(), 1)
  end

  defp turn_off do
    Circuits.GPIO.write(output_gpio(), 0)
  end

  defp output_gpio do
    {:ok, output_gpio} = GPIO.open(@output_pin, :output)
    output_gpio
  end
end
