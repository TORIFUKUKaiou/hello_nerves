defmodule Qiita.Events.Markdown do
  @type items :: list()

  @callback generate(items) :: String.t()
end
