defmodule AwesomeNerves.SetInterrupter do
  use GenServer

  require Logger

  alias Circuits.GPIO

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    GPIO.set_interrupts(AwesomeNerves.Util.input_gpio(), :both, receiver: AwesomeNerves.Observer)

    GPIO.set_interrupts(AwesomeNerves.Util.weather_input_gpio(), :both,
      receiver: AwesomeNerves.Observer
    )

    {:ok, state}
  end
end
