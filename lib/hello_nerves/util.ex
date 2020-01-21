defmodule HelloNerves.Util do
  alias Circuits.GPIO

  @input_pin Application.get_env(:hello_nerves, :input_pin, 24)

  def input_gpio do
    {:ok, input_gpio} = GPIO.open(@input_pin, :input)
    input_gpio
  end

  def input_pin, do: @input_pin
end
