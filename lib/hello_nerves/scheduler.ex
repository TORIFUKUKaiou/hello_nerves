defmodule HelloNerves.Scheduler do
  use Cronex.Scheduler

  every :day, at: "22:00" do
    HelloNerves.update()
  end
end
