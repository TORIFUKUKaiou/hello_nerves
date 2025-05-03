defmodule AwesomeNerves.Led do
  def run, do: spawn(AwesomeNerves.Led, :blink, [])

  def blink do
    turn_on()
    Process.sleep(500)
    turn_off()
    Process.sleep(500)

    blink()
  end

  defp turn_on do
    Circuits.GPIO.write(gpio(), 1)
  end

  defp turn_off do
    Circuits.GPIO.write(gpio(), 0)
  end

  defp gpio do
    {:ok, gpio} = Circuits.GPIO.open(18, :output)
    gpio
  end
end
