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
    f =
      [&one/0, &two/0, &three/0, &four/0, &five/0, &six/0]
      |> Enum.random()

    f.()
  end

  def random_forever do
    random()

    50..75
    |> Enum.random()
    |> Process.sleep()

    random_forever()
  end

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
