defmodule HelloNerves.Scheduler do
  use Cronex.Scheduler

  every :day, at: "22:00" do
    HelloNerves.update()
  end

  every :day, at: "14:00" do
    HelloNerves.update()
  end

  every :day, at: "22:05" do
    HelloNerves.tweet_autorace()
  end
end
