defmodule HelloNerves.Led.SevenSeg do
  @a_led_pin Application.get_env(:hello_nerves, :a_led_pin, 13)
  @b_led_pin Application.get_env(:hello_nerves, :b_led_pin, 6)
  @c_led_pin Application.get_env(:hello_nerves, :c_led_pin, 5)
  @d_led_pin Application.get_env(:hello_nerves, :d_led_pin, 20)
  @e_led_pin Application.get_env(:hello_nerves, :e_led_pin, 21)
  @f_led_pin Application.get_env(:hello_nerves, :f_led_pin, 19)
  @g_led_pin Application.get_env(:hello_nerves, :g_led_pin, 26)

  alias Circuits.GPIO

  require Logger

  def clear do
    [@a_led_pin, @b_led_pin, @c_led_pin, @d_led_pin, @e_led_pin, @f_led_pin, @g_led_pin]
    |> Enum.map(&gpio(&1))
    |> Enum.map(&turn_off(&1))
  end

  def random do
    1..6
    |> Enum.random()
    |> show()

    50..75
    |> Enum.random()
    |> Process.sleep()

    random()
  end

  def show(1), do: one()

  def show(2), do: two()

  def show(3), do: three()

  def show(4), do: four()

  def show(5), do: five()

  def show(6), do: six()

  def one do
    clear()
    [@b_led_pin, @c_led_pin] |> flush()
  end

  def two do
    clear()
    [@a_led_pin, @b_led_pin, @g_led_pin, @e_led_pin, @d_led_pin] |> flush()
  end

  def three do
    clear()
    [@a_led_pin, @b_led_pin, @g_led_pin, @c_led_pin, @d_led_pin] |> flush()
  end

  def four do
    clear()
    [@f_led_pin, @g_led_pin, @b_led_pin, @c_led_pin] |> flush()
  end

  def five do
    clear()
    [@f_led_pin, @g_led_pin, @c_led_pin, @d_led_pin, @a_led_pin] |> flush()
  end

  def six do
    clear()
    [@f_led_pin, @e_led_pin, @d_led_pin, @c_led_pin, @g_led_pin] |> flush()
  end

  defp flush(pins) do
    pins
    |> Enum.map(&gpio(&1))
    |> Enum.map(&turn_on(&1))
  end

  defp turn_on(gpio) do
    GPIO.write(gpio, 1)
  end

  defp turn_off(gpio) do
    GPIO.write(gpio, 0)
  end

  defp gpio(pin) do
    {:ok, output_gpio} = GPIO.open(pin, :output)
    output_gpio
  end
end
