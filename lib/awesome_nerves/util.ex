defmodule AwesomeNerves.Util do
  alias Circuits.GPIO

  @input_pin Application.compile_env(:hello_nerves, :input_pin, 24)
  @weather_input_pin Application.compile_env(:hello_nerves, :input_pin, 21)

  def input_gpio do
    {:ok, input_gpio} = GPIO.open(@input_pin, :input)
    input_gpio
  end

  def weather_input_gpio do
    {:ok, weather_input_gpio} = GPIO.open(@weather_input_pin, :input)
    weather_input_gpio
  end

  def input_pin, do: @input_pin

  def weather_input_pin, do: @weather_input_pin
end
