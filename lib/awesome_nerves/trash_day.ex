defmodule AwesomeNerves.TrashDay do
  def run do
    now = Timex.now() |> Timex.shift(hours: 9)
    day_of_week = Date.day_of_week(now)
    week_of_month = Timex.week_of_month(now)

    do_run(day_of_week, week_of_month)
  end

  defp do_run(day_of_week, _week_of_month) when day_of_week == 1 or day_of_week == 4 do
    msg("可燃ごみ")
    |> post()
  end

  defp do_run(3, week_of_month) when week_of_month == 2 or week_of_month == 4 do
    msg("空き缶・空き瓶")
    |> post()
  end

  defp do_run(3, 1) do
    msg("不燃ごみ")
    |> post()
  end

  defp do_run(_day_of_week, _week_of_month), do: nil

  defp msg(trash), do: "#{trash}の日です。忘れずに捨てましょう！"

  defp post(msg), do: AwesomeNerves.LineNotify.post(msg)
end
